# Request canonicalization

Version: 0 (work in progress)

## Introduction and rationale

A Ouinet client receives HTTP requests from a browser.  It may then use those
requests to look up content in Ouinet's distributed cache, or to ask a Ouinet
injector to store that content in the cache.

The same resource (identified by its URL) may have different versions stored
in the cache as as a result of a previous request for the same resource from
this or another Ouinet client.  To help Ouinet nodes (both clients and
injectors) decide which of those versions can be best used as a base for a
response a subsequent request coming from a client, information about both the
request and the response is stored in the cache.

The original browser HTTP request could be stored for that purpose, since it
contains relevant information like preferred languages, accepted content types
or CORS headers which could yield a completely different result on the same
URL.  However, storing everything goes against two fundamental principles in
Ouinet's design regarding cached content:

  - *Reusability:* For the sake of avoiding the storage of many different
    requests that vary in small details, some headers should be simplified or
    dropped, and some fixed formatting for fields adopted.  Having the same
    stored request for really similar browser requests increases the chances
    of a cache hit and therefore the utility of the cache.

  - *Privacy:* Cached content is supposed to be public, so sensitive
    information like authentication tokens and cookies should be removed.
    Stored requests may try to mimic those of particular browsers to both
    increase reusability and avoid fingerprinting Ouinet injectors (more
    radical alterations of requests to further increase privacy should be
    handled by the user via anonymizing browsers or proxies).

Also, Ouinet's distributed cache acts in a manner as an HTTP proxy cache, and
as such it may enable cache poisoning attacks.  Cleaning requests from
non-necessary headers can block some of these attacks.

This document specifies the processing of an HTTP request coming from a
browser into a **canonical request** to be used for storage in the distributed
cache and for other purposes.  In general, this specification strives to
incorporate as much information from the browser request as possible as long
as it is relevant to determine its outcome and it does not conflict with the
aforementioned principles.

XXXX REVIEW THIS:

Also for readability and usability purposes, canonical requests following this
specification should be usable as plain HTTP requests themselves.  Final
requests delivered from Ouinet injectors to origin servers should be as close
as possible to their canonical counterpart (bar minor changes not affecting
its meaning).  This may help ensure that the actual content injected into the
distributed cache does not significantly differ from what the Ouinet client
expects given the canonical request.

## General request format

XXXX REVIEW THIS, SEPARATE STORAGE FROM WIRE USAGE:

Canonical requests have the form of *HTTP/1.1 proxy requests* as described in
<https://tools.ietf.org/html/rfc7230> (i.e., with an absolute target URI like
``https://example.com/foo.html`` instead of just ``/foo.html``).  This helps
distinguish HTTP from HTTPS requests, and they should still work without
modifications with compliant HTTP/1.1 servers.

Regarding request target URIs, schemes and host names are represented in lower
case, with IDNA encoding applied where required.  In URI paths, non-printable
characters, space, and non-ASCII characters are represented using
percent-encoding with upper case letters (e.g. ``ç`` is encoded as ``%C3%A7``,
see <https://tools.ietf.org/html/rfc3986>), while the rest of characters use
their plain representation.  The same rules also apply to headers containing
URI components like ``Host``.

After the request line, the ``Host`` header is included as the first header
(as recommended in <https://tools.ietf.org/html/rfc7230#section-5.4>), and
afterwards the rest of headers in US-ASCII alphabetical order.  The line
separator used is the normal CRLF pair as indicated in the RFC.

Header names must follow camel-case capitalization as used in RFCs and by most
browsers, i.e. the first letter in the header and letters inmediately
following a dash are capitalized (e.g. ``Content-Type``).  Acronyms (like
``DNT``) are fully capitalized too.

Header values are separated from header names by a single space and they have
no trailing spaces.

The empty line that marks the end of request headers must be included in the
canonical request.  Please note that canonical requests have no body.

Also note that the formatting of a canonical request may be altered when
sending it to the origin server to better mimic the canonical ``User-Agent``,
as long as its contents do not change.  For instance, the order or encoding of
headers may change, and the target URI will be made relative.

## Header actions

Possible actions on request headers:

  - KEEP: The original value is used (if correct), it is converted to a
    canonical format and included in the canonical request.
  - PROCESS: The original value is used to compute a possibly different value,
    and the later is used and included in the canonical request.
  - ADD: A new value which is not derived from the original one (if any) is
    used, and it is included in the canonical request.
  - DROP: The header is not used nor included in the canonical request, nor
    sent to the next recipient(s).
  - PASS: The header is not included in the canonical request, but it may be
    used by the recipient and sent to the next recipient(s).

In general, a request sent from a Ouinet client to an injector should already
be canonical.  However, the message may also contain headers marked with PASS
(for instance, ``Cache-Control`` and ``If-*`` directives, range or
connection-related headers like ``Range: bytes=200-1000``, ``Connection:
keep-alive`` or ``TE: gzip``).  Effects from the these headers in the form of
response headers (like ``Connection: keep-alive``, ``Keep-Alive:
timeout=5,max=1000``, ``Tranfer-Encoding: gzip``) and alterations to the
representation (like content ranges or a compressed body) must not be part of
cached data.

## List of request headers and actions

Headers not listed below are always dropped (DROP action).

Ad hoc headers:

  - `X-Ouinet-Version`: ADD: This indicates what version of the
    canonicalization procedure has been used for this request.  This allows
    several versions of the software to coexist on using the same distributed
    database, and in the future it may allow injectors to inject
    backwards-compatible keys for the same resource.

    This header must be removed by injectors when contacting origin servers
    since the concept of a canonical request is useless to them (plus it may
    help them fingerprint Ouinet injectors).

From <https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Request_fields>:

  - `Accept`: PROCESS: Browsers use this header to indicate preferences for
    the type of content, and the same URL (e.g. for a CSS style sheet) may get
    a different header depending on whether it was entered in the location bar
    or retrieved following a link in a page.

    One approach which maximizes reusability of requests and content is to
    always send ``Accept: */*``, since browsers do not use to send values with
    ``;q=0`` (in which case a ``406 Not Acceptable`` error would be returned).
    However this helps fingerprint requests as coming from a Ouinet injector.
    It also might yield representations less specific than asked for by the
    browser, though this would be unusual for browsing.

    The opposite approach is to just keep the value sent by the client.
    Though yielding results more similar to normal browsing, this would (i)
    reduce reusability (e.g. when requesting the same resource with different
    browsers) and (ii) help fingerprinting by means of identifying values
    inconsistent with the canonical ``User-Agent``.

    A middle approach which maximizes reusability and minimizes fingerprinting
    is to spot the generic content type (HTML, image, style sheet, font,
    script…) with highest quality (i.e. ``;q=1``  or no ``q`` value) from the
    header provided by the browser, and instead use the header used by the
    canonical ``User-Agent`` for that type.  If no known generic type is
    identified, the header is passed as is (since probably the user is
    performing a very precise request, e.g. for REST).

    This is the mechanism used to canonicalize this header.

    For instance, given the Chromium browser request preferring HTML with:

        User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8

    It would be mapped to Firefox's:

        User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8

  - `Accept-Charset`: DROP: Browsers do not usually provide this header (as
    noted in <https://tools.ietf.org/html/rfc7231#section-5.3.3>), it helps
    fingerprinting them and they can usually handle whatever charsets.

    If the original request from the browser explicitly forbids some charset
    (i.e. it contains a value with ``;q=0``), the Ouinet client must return
    the error ``406 Not Acceptable``.

  - `Accept-Encoding`: ADD: Since the use of this header does not affect the
    actual content of the resource but just its representation, and since
    responses may always use identity encoding (unless explicitly prohibited,
    see <https://tools.ietf.org/html/rfc7231#section-5.3.4>), to augment
    request reusability and the reusability of content itself, an empty
    ``Accept-Encoding: `` is added (signalling that only the identity encoding
    is accepted).

    This means that content is always stored in the Ouinet distributed cache
    in uncompressed form.  To transfer data from an injector in compressed
    form, the ``TE`` header for transfer encoding should be used instead.

    If the original request from the browser explicitly forbids identity
    encoding, the Ouinet client must either reencode the response body to
    some accepted encoding, or return the error ``406 Not Acceptable``.

    Please note that the particular value used for this header may help
    fingerprint requests as coming from a Ouinet injector.  If this is a
    problem, the injector may provide to the origin server a value which
    mimics that sent by the canonical ``User-Agent`` (e.g. ``gzip, deflate,
    br`` for Firefox), but still undo the encoding if injecting the resource
    into the distributed cache.[^1]

    **Note:** When the response from the origin server uses a
    ``Content-Encoding`` which is not the identity, undoing the encoding of
    the content implies a transformation, as indicated in
    <https://tools.ietf.org/html/rfc7230#section-5.7.2>, and injected headers
    must include a ``Warning`` with ``214 Transformation Applied``.  A ``203
    Non-Authoritative Information`` response status code may be returned by
    the injector, but that may probably cause issues with simple browsers, so
    the original code is kept.  Also, if the request contained
    ``Cache-Control: no-transform``, the injector must just return an error.

  - `Accept-Language`: PROCESS: We need to balance the reusability of requests
    and the availability of cached content, but at the same time we want to
    keep the cultural diversity of stored content and avoid discrimination
    against languages.

    One simple approach is to just keep the header in the request, but the
    great variability of languages, region-specific locales and
    language-related user prefences would much detract from reusability.  It
    would also help fingerprint particular users of Ouinet (although this
    should be handled by the user externally).

    Another simple approach is to just use the default header value for the
    canonical ``User-Agent``.  However that would be discriminatory and
    detract from cultural diversity.  Also, some brosers do not have
    meaningful defaults (e.g. Chrome/Chromium always resorts to the system's
    locale).

    A balanced approach is to use the canonical browser's default
    ``Accept-Language`` (AL) header when possible, and otherwise keep the
    user's configuration with some simplifications to reduce variability.  The
    procedure can be summarized as:

      - IF (browser's AL equals canonical browser's default AL)  
        THEN (keep AL header)
      - ELSE

          1. remove canonical browser's default AL from the tail of the
             browser's AL
          2. convert "LANGUAGE_REGION" entries to "LANGUAGE", remove quality
             values, remove remaining duplicates (keep first occurence)
          3. if previously removed, add canonical browser's default AL to the
             tail, remove quality values
          4. compute quality values according to canonical browser
          5. format according to canonical browser

    This means that, given one resource available in different regional
    variants of the same language, Ouinet may only cache one variant, namely
    that returned by the origin server when no regional variant is indicated.

    This is the mechanism used to canonicalize this header.

    For instance, given the following Chromium request with preference for
    content in Catalan (from the system) then German:

        User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36
        Accept-Language: ca-ES,ca;q=0.9,de;q=0.8

    It would be mapped to Firefox's:

        User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0
        Accept-Language: ca,de;q=0.8,en-US;q=0.5,en;q=0.3

    (Firefox's default AL value is ``en-US,en;q=0.5``; given N entries it
    assigns the implicit quality 1 to the first one and (N-POSITION+1)/N to
    the rest, rounded to one decimal.)

    Ouinet users may be reminded to alter their browsers' language preferences
    when some resource can not be retrieved from the cache.  They may also be
    reminded about browser fingerprinting when using very rich language
    configurations (see <https://tools.ietf.org/html/rfc7231#section-9.7>).
    Ouinet tools may ease temporarily reverting language configuration to the
    canonical browser's default.

  - `Accept-Datetime`: KEEP: Although the Memento framework (see
    <http://mementoweb.org/guide/howto/>) is not yet an accepted standard,
    many web archival and other repository-like sites do support it.  Keeping
    the header opens the door to using Memento-aware browsers to pull
    particular snapshots of pages into the Ouinet distributed cache, even when
    they are no longer available online.

    The header accepts arbitrary dates, which would reduce the reusability of
    requests drastically.  However, particular dates are expected to come from
    existing time maps for resources supporting the framework.

  - `Access-Control-Request-Method`: DROP: It has no purpose for GET or HEAD
    and it reduces request reusability.

  - `Access-Control-Request-Headers`: DROP: Same reason.

  - `Authorization`: DROP: Having authentication tokens potentially published
    to the distributed cache is an unacceptable risk to the user's privacy and
    security.

    This means that Ouinet access via injector or cache only supports
    anonymous access to pages.  If the user actually wants to authenticate to
    a site, requests should be routed to origin or proxy mechanisms.

    As a side note, ``401 Unauthorized`` responses with ``WWW-Authenticate``
    headers must not be cached either since they may contain one-use values
    (like HTTP digest nonces) which would help fingerprint different Ouinet
    users after they retried authentication via a different request mechanism.

  - `Cache-Control`: PASS: The meaning of these directives depends on the
    moment when the request takes place, which makes no sense when reusing
    requests in the future (unless canonical requests reused a ``Date``, which
    they do not).

    However these directives may still be useful for the Ouinet client or
    injector to decide whether a resource in the distributed cache can be used
    or not, so the client may still pass them to the injector.  An injector
    may decide on its own whether to cache again an already cached resource
    which is still fresh, but not enough for a particular request.

  - `Connection`: DROP: This header only indicates how the connection to the
    first entity takes place, it is irrelevant for further or future
    connections.

  - `Cookie`: DROP: Having cookies potentially published to the distributed
    cache is an unacceptable risk to the user's privacy and security.

    This means that Ouinet access via injector or cache only supports
    anonymous access to pages.  If the user actually wants to use cookies,
    requests should be routed to origin or proxy mechanisms.

    As a side note, ``Set-Cookie`` response headers must not be cached nor
    passed on by injectors to avoid the server to use cookies for
    fingerprinting different Ouinet users that first access a cached page and
    proceed to other mechanisms when cookies for the site are available
    (although the server may be using other fingerprinting mechanisms).

  - `Content-Length`: DROP: GET or HEAD requests should not carry a relevant
    body.

  - `Content-MD5`: DROP: Same reason.

  - `Content-Type`: DROP: Same reason.

  - `Date`: DROP: Including it would make most requests to the same resource
    different and very hard to reuse, unless a global, very coarse clock was
    used for donwsampling different close times to the same representation.
    However, a global clock is difficult to handle and deciding adequate
    intervals in the general case is not possible.

  - `DNT`: KEEP: Although tracking requests from injectors may be meaningless
    to an origin server, the tracking preference should still be explicitly
    set by the user, and its value (or absence of it) respected according to
    <https://www.w3.org/TR/tracking-dnt/#determining> (even when it may
    detract from request reusability for Ouinet).

    Please note that automatically adding ``DNT: 1`` as a way to suggest the
    worthiness of tracking injectors may actually help fingerprint Ouinet (see
    <https://blog.torproject.org/improving-private-browsing-modes-do-not-track-vs-real-privacy-design).

  - `Expect`: DROP: Interim responses are not supported by Ouinet's
    request/response model, and it is probably useless for HTTP safe requests.
    Also, no known browsers use this feature (according to
    <https://developer.mozilla.org/ca/docs/Web/HTTP/Headers/Expect>).

  - `Forwarded`: DROP: It may reveal private information about users using
    proxies in front of a Ouinet client, thus it should not risk being cached.
    The information about the request host and protocol is already available
    in the absolute request target.

  - `From`: KEEP: This may be used by certain clients or projects to
    differentiate their requests from others.  Clients pulling content for
    others to reuse directly should not use this header to avoid differing
    requests.

  - `Host`: KEEP: For the request to be valid HTTP/1.1, this header must
    always be the first one (see
    <https://tools.ietf.org/html/rfc7230#section-5.4>).  This is in spite of
    the information being already available in the request target.[^1]

  - `If-Match`: PASS: Same as ``Cache-Control``.

    Please note that ``304 Not Modified`` responses must not be cached by the
    injector since they only make sense for the moment when the request takes
    place.

  - `If-Modified-Since`: PASS: Same as ``If-Match``.

  - `If-None-Match`: PASS: Same as ``If-Match``.

  - `If-Range`: PASS: Same as ``Range``.

  - `If-Unmodified-Since`: PASS: Same as ``If-Match``.

  - `Max-Forwards`: DROP: It has no purpose for GET or HEAD and it reduces
    request reusability.

  - `Origin`: KEEP: This header is part of CORS requests and removing it from
    the canonical representation would break the protections that it offers.

  - `Pragma`: PASS: Same as ``Cache-Control``.

  - `Proxy-Authorization`: DROP: If the Ouinet client requested authorization,
    this token would be a private one not to be revealed to injectors.

  - `Range`: PASS: Resources become more reusable if they are stored in full
    in the distributed cache.  Also, accepting ranges in canonical requests
    would make them very variable and less reusable.  Thus, partial content is
    not to be cached by either injectors nor clients.  Instead, the full
    resource should be cached (if available).

    According to <https://tools.ietf.org/html/rfc7233#section-3.1>, returning
    the full resource is always a correct option, even when ranges are
    requested.  An injector may request the full resource to the origin
    server, cache it (``200 OK``), and return it entirely or in part, or it
    may request and return part of the resource and not cache it (``206
    Partial Content``).  Clients may follow a similar strategy with injectors,
    with a preference for returning the requested partial content to the
    browser.  Both clients and injectors may also fetch partial content from
    the distributed cache, where the resource should be stored in full.

    This means that requesting a range in Ouinet may imply that the full
    resource is downloaded by an injector or a client, which would result in
    higher delays, also if the underlying cache back end does not support
    retrieving ranges.

  - `Referer`: DROP: Besides revealing part of the user's browsing history
    (which may be avoided by using dedicated tools like Privoxy, Tor
    Browser…), including this information would reduce request reusability for
    probably no relevant benefit.

  - `TE`: DROP: This header only indicates how the transfer with the first
    entity takes place, it is irrelevant for further or future connections.

  - `User-Agent`: ADD: Although we may want to leave privacy enhancement of
    requests to dedicated tools (Privoxy, Tor Browser…), leaving the browser's
    potentially very diverse user agent string as is would much reduce the
    reusability of requests.

    A fixed, popular user agent may be claimed (as in Tor Browser) so as to
    not give away the use of Ouinet to origin servers.  However, many sites
    offer radically different versions of pages depending on the user agent,
    and a user agent string from a reduced set (e.g. desktop, mobile, command
    line) may be used instead, to be chosen by the client depending on the
    user agent coming from the browser or via configuration.

      - Desktop: ``Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0``
      - Mobile: TO DO
      - Command line: TO DO

  - `Upgrade`: DROP: Connection upgrades are not supported by Ouinet's
    request/response model.

  - `Upgrade-Insecure-Requests`: KEEP: Enables the *Upgrade Insecure Requests*
    mechanism so that clients are either served the plain HTTP resource or
    redirected to HTTPS, and the decision is also reflected in the cache.

  - `Via`: DROP: It may reveal private information about users using proxies
    in front of a Ouinet client, thus it should not risk being cached.

  - `Warning`: DROP: It does not add real value to the request and it may
    reduce request reusability.

    As a side note, ``Warning`` headers may be injected in responses by the
    Ouinet client to the browser, e.g. when already stale content has been
    retrieved from the cache or when the client had to resort to the cache
    after failing to contact the origin direct or indirectly (see
    <https://tools.ietf.org/html/rfc7234#section-5.5>).

[^1]: Alternatively, the injector may add or extend the header when contacting
    the origin server.  However in this proposal we try to have both request
    representations as close as possible, so that the canonical request can
    actually be used as a real request.

## Examples

(In examples, ``(CRLF)`` followed by a new line correspond to the CRLF line
separator.)

A simple request coming from a desktop browser for URL
``https://δοκιμή.foo/test.html?q=δ``, with Catalan language preference:

    GET https://xn--jxalpdlp.foo/test.html?q=%CE%B4 HTTP/1.1(CRLF)
    Host: xn--jxalpdlp.foo(CRLF)
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8(CRLF)
    Accept-Encoding: (CRLF)
    Accept-Language: ca,en-US;q=0.7,en;q=0.3(CRLF)
    Upgrade-Insecure-Requests: 1(CRLF)
    User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0(CRLF)
    X-Ouinet-Version: 0(CRLF)
    (CRLF)

A ``HEAD`` request with all possible headers:

    HEAD https://example.com/api/users HTTP/1.1(CRLF)
    Host: example.com(CRLF)
    Accept: application/json(CRLF)
    Accept-Datetime: Thu, 10 Jan 2018 12:34:00 GMT(CRLF)
    Accept-Encoding: (CRLF)
    Accept-Language: en-US,en;q=0.5(CRLF)
    DNT: 1(CRLF)
    From: Ouinet API tester(CRLF)
    Origin: http://example.net:8080(CRLF)
    Upgrade-Insecure-Requests: 1(CRLF)
    User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/60.0(CRLF)
    X-Ouinet-Version: 0(CRLF)
    (CRLF)
