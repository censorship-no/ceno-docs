% Proposal for alternate cache model

The current [Ouinet cache model][] has some shortcomings:

  - Individual versions of a URI are not addressable since the URI->descriptor
    mapping is mutable and versions are just an array of identity-less items,
    i.e. version N of URI X at a given moment may have nothing to do with
    version N of URI X at a different moment.

  - As a result, if a client wants to seed the descriptor for a version of a
    URI that it is seeding, retrieving the descriptor from the distributed
    cache data base does not ensure that any of the versions it contains
    actually matches the one that it is seeding (they might just share the
    same data).

  - Versions can not be independently validated by injectors.  In contrast,
    they must accept the whole set of versions contained in the descriptor,
    evenf if they do not share the same grouping criteria.

  - As a result, data base republishers can not themselves group using
    different criteria than injectors.

[Ouinet cache model]: https://github.com/equalitie/ceno2/blob/master/doc/cache.md

This proposal decouples grouping from signing, so injectors sign individual
versions, and the grouping is performed at the data base level.

Before:

  - Data base validates 1-to-1 *URI->descriptor* mapping.
  - Injector validates 1-to-N *descriptor->{version1, version2…}* mapping.

After:

  - Data base validates 1-to-N *URI->{descriptor1, descriptor2…}* mapping.
  - Injector validates 1-to-1 *descriptor->version* mapping.

This gives more flexibility for data base publishers to group versions as
wanted and makes the behaviour of data bases (either run by injectors,
republishers or clients) more uniform.

## New descriptor format

It is similar to the previous format, whith two main differences:

 1. It only describes one single version.
 2. It includes a UUID which is unique to this version of the URI resource.

    That means that the URI+UUID combination should be unique and no injector
    should sign more than once a descriptor with the same combination of
    URI+UUID using the same key (it is ok to use a different key when
    migrating keys, though).

    A UUID is chosen instead of some hash because (i) different requests to
    the same URI may result in the same data, and (ii) the identifier may be
    communicated to the client by the injector before it knows necessary
    information to build the descriptor (see below).  Some sequential number
    is not used because it may cause issues to concurrently operating injector
    hosts from the same service.

Descriptor example (for an HTTP URI, with HTTP metadata):

```json
{
    "ouinet_descriptor_version": 0,
    "uris": ["https://example.com/foo", "https://archive.example.com/2018/foo"],
    "uuid": "15bb4f34-ca7e-4f42-9b01-f147e9abcce9",
    "ts": "2018-01-15T21:31:44Z",
    "data_length": 38,
    "data_hash": "DATAHASH1",
    "data_links": [
        "ipfs:/ipfs/QmXYZ…",
        "data:,%3C%21DOCTYPE%20html%3E%0A%3Cp%3ETiny%20body%20here%21%3C%2Fp%3E"
    ],
    "meta_http_rqh": {"@method": "GET", "@target": "https://example.com/foo", "@version": "HTTP/1.1",
                      "host": "example.com",
                      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"},
    "meta_http_rph": {"@version": "HTTP/1.1", "@code": "200", "@reason": "OK",
                      "date": "Mon, 15 Jan 2018 20:31:50 GMT", "server": "Apache",
                      "content-type": "text/html",
                      "content-disposition": "inline; filename=\"foo.html\""},
    "signatures": {
        "ed25519:XXXX1#0": {
            "ed25519:0": "YYYY1", "ts#ed25519:0": "2018-01-15T21:31:51Z",
            "desc": "FooBar injector service"
        },
        "ed25519:XXXX2#0": {
            "ed25519:0": "YYYY2", "ts#ed25519:0": "2018-01-15T21:45:10Z",
            "desc": "XYZ injector service"
        }
    },
    "unsigned": {
        "data_links": [
            "ipfs:/ipfs/QmXYZ…", "magnet:?xt.1=urn.sha1:ZYX…",
            "data:,%3C%21DOCTYPE%20html%3E%0A%3Cp%3ETiny%20body%20here%21%3C%2Fp%3E",
            "http://…", "ftp://…", "file://./data/…"
        ]
    }
}
```

## UUID reporting

When a client requests a resource to be injected, the injector replies back
with the UUID for the particular version that it is sending to the client,
either from an already cached version or newly generated otherwise.  This
allows the client to later on retrieve the descriptor of that exact version
from the data base and seed it to others along the data that it got from the
injector.

For instance, the HTTP-based injector request:

    GET https://example.com/foo HTTP/1.1
    Host: example.com
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    X-Ouinet-Version: 0

Gets the following response:

    HTTP/1.1 200 OK
    Date: Mon, 15 Jan 2018 20:31:50 GMT
    Server: Apache
    Content-Type: text/html
    Content-Disposition: inline; filename="foo.html"
    X-Ouinet-UUID: 15bb4f34-ca7e-4f42-9b01-f147e9abcce9

    <!DOCTYPE html>\n<p>Tiny body here!</p>

If the client later looks up the data base for URI ``https://example.com/foo``
and UUID ``15bb4f34-ca7e-4f42-9b01-f147e9abcce9`` it will get the descriptor
shown above (if it is still present).

## Versions in a data base

Generally speaking, a data base provides the following interface:

    lookup(URI) -> [descriptor1, descriptor2…]

The nature of a data base dictates which versions for the same URI are kept.

For instance, in a centrally-managed db like the current IPNS+IPFS one kept by
an injector service, the service decides which versions are kept and which are
evicted according to its own criteria.  This case is similar to that of a db
republisher choosing which versions from which sources to publish.

In a more decentralized db (e.g. BEP5-based), the set of versions retrieved by
a lookup depends on which of them are currently available from other nodes
(with each node having 0, 1 or N versions for a given UUID).

## Mixed data bases

Usually a data base will point to descriptors hosted by itself.  If a data
base pointed to descriptors in different storages (or just listed UUIDs for a
URI), additional lookup steps would be needed that would complicate the
system, so supporting such mixed data bases should be discussed.

However, there may be data base mechanisms that abstract several data bases
(e.g. IPFS, BEP5, file system…) to gather descriptors from all of them at a
time, if so desired.

## Request flow example

This example covers the case where a client wants some content which is not in
the distributed cache, and it decides to route the request to an injector.

(Ordered items happen in sequence and unordered in parallel.)

 1. The Client receives ``request(URI)`` from the Browser.

 2. The Client sends ``request(URI)`` to the Cache.

    The Cache replies that no descriptors for the URI are available.

 3. The Client sends ``request(URI)`` to the Injector.

     1. The Injector sends ``request(URI)`` to the Cache.

        The Cache replies that no descriptors for the URI are available.

     2. The Injector sends ``request(URI)`` to the Origin.

        The Origin replies with ``response(URI)`` (for HTTP that means the
        response head and body).

     3. The Injector generates a UUID for that request/response.

     4. With ``request(URI)``, ``response(URI)`` and UUID, the Injector:

          - Replies ``response(URI)+UUID`` to the Client.

          - Proceeds to *injection*:

             1. It creates an *incomplete descriptor* lacking members
                ``data_links`` and ``signatures`` and starts seeding *data* to
                distributed caches.

             2. When data upload is complete, it fills the missing members of
                the descriptor (including the signature) and inserts the
                *descriptor* into the data base.

 4. The Client receives ``response(URI)+UUID`` and:

      - Sends the response to the Browser.

      - Seeds the response *data* to distributed caches.

      - Proceeds to *descriptor request*:

         1. After a given pause, it requests the descriptor for URI+UUID from
            the data base.  This step is repeated until the request succeeds
            and the descriptor is retrieved.

         2. It seeds the *descriptor* to distributed caches.

## Ouinet URIs

Since a URI and a UUID identifies a specific version, we can envision Ouinet
URIs to address them, something in the lines of:

    ouinet://VERIFICATION_KEY/URI_HASH/UUID

With ``VERIFICATION_KEY`` as an explicit URI authority.

    ouinet:///URI_HASH/UUID

Here the URI authorithy is implicit.  If the client accepts different
verification keys, any descriptor found with a correct signature is returned
(hopefully they share the same content).

In the anomalous event that different descriptors with different time stamps
are found for the same key+URI+UUID, the oldest one is returned.

Also note that it is still feasible that different clients get different,
correct descriptors for the same Ouinet URI.  To add immutability to a Ouinet
URI some hash on the descriptor content, or the signature for a particular
key, may be added.

## Note on signature format

Descriptor signing is based on [Matrix JSON signing][], with some
peculiarities.

[Matrix JSON signing]: https://matrix.org/docs/spec/appendices.html#signing-json

```json
{
    "signatures": {
        "ed25519:XXXX1#0": {
            "ed25519:0": "YYYY1", "ts#ed25519:0": "2018-01-15T21:31:51Z",
            "desc": "FooBar injector service"
        },
        "ed25519:XXXX2#0": {
            "ed25519:0": "YYYY2", "ts#ed25519:0": "2018-01-15T21:45:10Z",
            "desc": "XYZ injector service"
        }
    }
}
```

Matrix uses an arbitrary name (like ``example.com``) to identify the set of
keys signing a document.  To avoid depending on some external mapping from
names to keys so that descriptors are self-contained, and since we are using
short Ed25519 keys, we use the very verification (public) key as a name, in
the format ``ed25519:<KEY>#<ID>`` where ``KEY`` is the Base64 representation
of the key, and ``ID`` is some short string to lookup the signature by key id
``ed25519:<ID>`` (the string ``0`` does the job).  A ``desc`` member may be
added to the signatures array for human readability purposes when using the
key as a name; it is ignored by Matrix's spec and it is not used for signing
nor validation (thus it might contain bogus information).

Please note that even if the whole public key is contained in the descriptor,
the client must anyway have already trusted it via external means (like user
configuration).

Since the Matrix spec only allows one signature per key id (which is BTW
desirable to us) but it does not support time stamps, we add a member that
associates the signature by key id ``ed25519:<ID>`` to a time stamp as the
member ``ts#ed25519:<ID>`` (which is also ignored by Matrix's spec).  When
checking the signature, a ``@signature_ts`` member is temporarily injected
with the associated time stamp into the main content (before getting its
canonical version).

In the example above, for the public (verification) key ``"ed25519:XXXX1#0"``
and its signature ``"ed25519:0": "YYYY1"``, the time stamp ``"ts#ed25519:0":
"2018-01-15T21:31:51Z"`` is used.

Since we specify the key and its id as the name, there can only be one
signature which makes sense in this case.  The rest of them
(e.g. ``ed25519:42``) are just ignored.  They would only make sense if we used
arbitrary names that could map to a set of key ids, as normal Matrix does.
This spec still supports this case since the time stamp member name contains a
reference to its associated signature (``ts#ed25519:<ID>``).
