# Censorship.no!

![](./images/ceno-logo.png "CENO logo")

CENO (short for [Censorship.no!][]) is a mobile Web browser using a novel approach to circumvent Internet censorship infrastructure, allowing users living in a censored zone to share retrieved content with each other, peer to peer. 

[Censorship.no!]: https://censorship.no/

CENO users do not need to know a friendly proxy server in an uncensored zone in order to bypass local filtering — setting CENO apart from most other circumvention initiatives.  CENO is being built in expectation of aggressive Internet filtering and the establishment of [national intranets][] to fence off nations from the Web.

[national intranets]: http://en.wikipedia.org/wiki/National_intranet

CENO is based on [Firefox for Android][] (a.k.a. Mozilla Fennec), extended to make use of the innovative [Ouinet library][], which allows web content to be served with the help of an entire network of cooperating nodes using peer-to-peer routing and distributed caching of responses.

[Firefox for Android]: https://www.mozilla.org/firefox/android/
[Ouinet library]: https://github.com/equalitie/ouinet/

The *Censorship.no!* project is run by [eQualitie][] in support of Articles 18, 19 and 20 of the [Universal Declaration of Human Rights]().  Please contact <cenoers@equalit.ie> in case of doubt or for further information.

[eQualitie]: https://equalit.ie/
[Universal Declaration of Human Rights]: https://www.un.org/en/universal-declaration-human-rights/

# Current Status

CENO is currently in ALPHA release. It is being tested in countries that censor large parts of the Internet from their citizens. A number of smaller tasks remain to be done before the software is moved into a BETA release.

# Warnings!

CENO is still **experimental ALPHA software**.  We offer it with the best intention that it is useful to you, but due to its highly innovative nature and stage of development, you may expect some issues while using it.

We recommend that you use this tool in controlled environments and **only assume reasonable risks**. eQualitie and its associates decline any legal responsibility derived from the use of this software. See 'Operational Warnings' below for more information on what you need to be aware of in running the Aplha release. 

## What currently works
  - Browse any website with normal speed when Internet access to the resource is not censored.
  - Browse any website (with slightly slower connection time) when it has been selectively censored (via DNS or IP).
  - Retrieve requested website content directly from the distributed cache and naturally browse web pages that other people have previously visited, even when the resource or any existing CENO injectors are not accessible. 
  
When users start the CENO browser, they automatically become part of the CENO network. This means that - when possible - these devices shall act as temporary proxies (bridges) for people who cannot access desired websites due to network censorship.

Provided that there are enough CENO bridges located outside of the censored zone, and that the country has not sealed off international communication completely, CENO users are able to connect to any website and then share its contents with other peers.

## Future functionality 
  - Retrieve and naturally browse content inserted off-line (like website captures) under a complete national Internet disconnection.

# How to use CENO

## As a user

Using CENO is as easy as downloading the application on an Android device and using it to browse websites as one would with any other mainstream browser.

One caveat at the moment, when accessing dynamic websites such as Twitter, Facebook or Gmail, one has to open and incognito tab in the CENO browser. This is because the non-incognito tab strips down all private data from HTTP requests to ensure they don't get leaked into the distributed cache.

On the other hand, the incognito tab leaves private data (e.g. passwords) intact but the connection stays encrypted and thus only the destination server can see the details of the HTTP transaction (making caching impossible).

## As a bridge

Bridges help route HTTP exchanges to and from censored zones. To become a bridge is again as easy as installing the CENO browser on an Android device and leaving it running for as long as possible. Make sure that your local wifi network supports UPnP. 

# Where to get it

The CENO browser for Android is available [in Google Play](https://play.google.com/store/apps/details?id=ie.equalit.ceno "CENO app in Google Play") and [in Paskoocheh](https://paskoocheh.com/tools/124/android.html "CENO app in Paskoocheh").  The Android package (APK) is also available [in GitHub](https://github.com/censorship-no/ceno-browser/releases "CENO app in GitHub").

CENO is completely Free/Libre/Open Source Software.  If you are interested in its source code please check the following Git repositories:

  - Browser components: [package builder](https://github.com/censorship-no/ceno-browser), [Firefox fork](https://github.com/censorship-no/gecko-dev/tree/ceno), [included extensions](https://github.com/censorship-no/ceno-distribution), [settings extension source](https://github.com/censorship-no/ceno-ext-settings)
  - [Ouinet source](https://github.com/equalitie/ouinet)
  - Other project-related repositories: [Censorship.no! GitHub organization](https://github.com/censorship-no)

You may also be interested in the (no longer maintained) [previous incarnation of CENO](https://github.com/censorship-no-archive/ceno1), built on the [Freenet][] anonymous file sharing and content publishing network.  Other inactive project-related repositories can be found at the [Censorship.no! archive](https://github.com/censorship-no-archive).

[Freenet]: https://freenetproject.org/

# Operational Warnings
## Battery and data usage

To prolong availability of CENO bridges, the CENO browser shall continue working even when it goes to the background. We have not yet put in place functionality which would disable all networking operations when the device switches to cellular internet, nor when it is disconnected from the charger. 

Until we implement this functionality, to preserve the device battery and network bandwidth, users need to explicitly disable CENO either by shutting it down from Android's list of running applications, or by tapping the "Tap to stop CENO" button from the notification area.

## CENO is not an anonymity tool

CENO users should also be aware of the fact that CENO is not a network to anonymize users such as Tor or I2P. More akin to BitTorrent, the IP addresses of users sharing particular content is visible to anyone who can understand the internal workings of the BitTorrent DHT protocol.

Information about your browsing might be leaked to other CENO users, as well as the fact that your application is providing particular web content to others. Content accessed with the application may remain in storage in clear text for
some time (continue reading for more information on this).  Other security or privacy-affecting issues might exist.

## Censorship circumvention will not always work

At the moment, CENO relies on bridge nodes whose IP addesses are not banned by countries performing network censorship. We rely on people living outside the censored zoen (this may be you!) running the CENO client and acting as bridges to people inside the censored zone. Currently, in the event of a complete internet blackout where no data can pass the internation boundary, CENO will cease to work.

The availability of web content (especially under censorship conditions) may vary widely with factors like web site configuration, network capacity, and the presence, connectivity and browsing behavior of other CENO users.  The behavior
of the mechanisms currently used to share content between users may be erratic.

In the future we're hoping to address these problem by:

1. Letting users "import" web content by other means than the Internet into a censored zone and disseminate it via decentralized content sharing protocols.
2. Modifying the protocol to find alternative routes to relay the traffic outside of the censored country and back (if one exists). 

# How does it work?

![Different ways of retrieving content over CENO](./images/ceno-access.svg)

When you access or *request* a web page using CENO, the application first looks at the browser request to decide whether the page seems *cacheable*, i.e. potentially safe to be saved and publicly shared with other CENO users (requests with authentication tokens, cookies or dynamic connections are not cached). Then it attempts to retrieve the page using several *mechanisms* until one of them succeeds:

  - It first attempts to retrieve the page straight from its **origin** (i.e. web server) as a normal browser would do.
  - If that fails, and the page seems cacheable, the application tries to get it from the **distributed cache**, i.e. from other CENO users that may have previously accessed it.  If it succeeds, the application itself starts sharing the page with other users.
  - If retrieving a cacheable page from the distributed cache fails, the application tries to retrieve it via an **injector**, a machine sitting in the uncensored zone which provides the application with the page content.  If the injector deems the *response* amenable to do so, it also provides additional information allowing users to share the page (which the application starts doing straight away).
  - If that fails, or if the page was not cacheable, the application uses the injector as a **proxy** to access content privately.  Neither the injector nor the application share the content publicly (in fact, when accessing secure web content, the injector is not even able to see the request and response themselves).

Users can selectively disable each of these mechanisms so that they are skipped altogether.  In the CENO application menu, just select the *CENO* entry and use the check boxes corresponding to the different mechanisms.

# Caching

Once a particular content has crossed the boundary to a censored zone, it is
furhter distributed in a BitTorrent-like fashion. This has several advantages:

* Content remains accessible even after the censor shuts down internation traffic completely.
* National traffic is often cheaper in censored countries which may lead to decreased internet price.
* Device to Device communication (currnetly WiFi only) may suffice in retrieving content.

# On content storage and availability

As you can see, your application will only be sharing *content that you have previously accessed*, and it will do that while it is running.  Conversely, if access to a page's origin or to the injector is not possible, the page will only be available if other users who have previously accessed the same page are still running their application.  The more applications actively sharing a page, the more chances for other users to get it.

Content does not stay in your device forever.  After your application has stored more than 10 gigabytes (this is not configurable for the moment), content which has not been accessed for the longest time (either by you or other users via your application) is removed to make space for new content.

If you want to remove all stored pages, you can use the standard procedures to delete the application's data in Android.  Be warned that currently *this will also remove other information* like favorites and browsing history from CENO.  We may later on add a way to remove stored pages without having to delete all application data.

# Help by becoming a bridge

As mentioned above, because random IP addresses are usually not blocked, CENO relies on users outside of censored zones to act as bridges. Therefore we'd like to ask people willing to help the CENO project as well as people behind the
internet walls to install the CENO browser on an Android device, start it up and let it run for as long as possible.

# CENO Browser Settings Page

CENO provides a small settings page that can be accessed by clicking the Fennec
"options" icon (three vertical dots in the top right corner) and then clicking
the "CENO" option. It should be noted that these settings need not be tweaked
for normal operation. As of this writing, they are mainly there to help debugging
different strategies of censorship avoidance.

In particular, the page contains these four editable options:

* Origin access: when enabled, this instructs CENO that it may try accessing
  the origin web server directly. Mostly for non encrypted web sites, it may
  be the case that the censor supplies to the user a bogus website in which
  case CENO can't distinguish it from the real one. In such case it may help
  to disable this option and thus to alway use CENOs multi hop transport
  to get the content.
* Proxy access: this option instructs CENO that it can bypass the distributed
  cache mechanism. If other options are disabled, HTTPS exchanges shall be
  routed through bridges and injectors, but they'll be encrypted in such a
  way that only the destination servers can decrypt them.
* Injector access: when enabled, HTTP requests made from the non-incognito
  tab shall be stripped from any private information (e.g. non white listed
  HTTP headers, GET variables and all non GET requests shall be stripped
  away) and sent to the injector. Injector shall get the HTTP response
  from origin servers, sign it and send it back to the CENO client. Because
  the response is signed, the CENO client shall start sharing that HTTP
  response using BitTorrent like protocol.
* Distributed cache option allows the CENO client to make HTTP requests 
  to the distributed cache.

# Threat model

When the CENO browser is started on a device, a number of internal IO processes
are activated. The primary one - one that does not depend on any prior browsing
- is that the app shall attempt to determine whether it can communicate with
its configured injector servers. This operation is likely to fail in heavily
censored countries, but when it does NOT fail, the application becomes a
bridge for others to reach injectors.

Another IO process that starts on app launch is content sharing of the distributed
cache. This action depends on whether a user has used this CENO browser in the
past to view public websites through the injector. If so, that particular content
shall be offered through BitTorrent's DHT network to others for download.

We call the former process as "acting as a bridge" and the latter as "acting as
a seeder". In addition, we call "acting as a user" the process of user browsing
internet websites. With this terminology in mind, users may ask the following
questions about the threat model:

## As a user

**Q1: As a user, can bridges see my communication with the destination websites?**

No. The only role of a bridge is to forward raw traffic between a user and an
injector. This communication is always encrypted using TLS and bridges don't
have the private keys required to access the content of the communication.

**Q2: As a user, can injectors see my communication with the destination websites?**

Yes and no. When the user requests a website from a non-incognito browser tab,
all private data is stripped away from all HTTP(S) requests, and only then
forwarded to the injector, encrypted with its public key. Stripped data
includes all non-white-listed HTTP header fields and GET query parameters. In
addition this is done only when the HTTP request is using the GET method.

On the other hand, when the user accesses a website using an incognito tab or
when non-GET HTTP method is used (e.g. POST, PUT,...), then no private data is
stripped away from the request, but the whole communication is encrypted with
the destination server's private keys. This means that in this other case the
injector can not decrypt the content.

**Q2: As a user, can injectors see my IP address?**

Yes. However, injectors can not distinguish whether the request came from a
CENO user or a bridge. Thus requests going to the injector can not be reliably
assigned an originating IP addresses.

**Q3: As a user, can my private data leak to the distributed cache?**

Hopefully not. As mentioned above, the CENO browser tries hard to strip away
any private data from any HTTP request going out. In addition, the injector
does not itself do any data sharing. In fact, the injector's sole purpose is
to sign the response so that the user can start sharing it (i.e. to act as
seeder). This means that when the HTTP response comes back to the CENO
browser, it is further analysed, and if the destination server indicates that
it's a private message, that is another clue for CENO not to seed it.

Still, there could be cases of badly designed or malicious pages which may
collect some information from you (like an email address in a form or some
browser fingerprints using Javascript) and stuff it in the URL of a GET
request as normal path components
(e.g. `http://example.com/subscribe/you@example.org`). If you suspect that a
page may be doing that, better be on the safe side and use an incognito tab.

## As a seeder

**Q4: As a seeder, what data is seeded from my device?**

Currently the only content that is seeded by a device is any non-private
HTTP(S) reponse for which the request went out from the non-incognito CENO
tab.

This means that users don't share anything they haven't accessed themselves
in the recent past.

**Q5: As a seeder, can an anyone find out what I seed?**

Yes and no. Anyone understanding the protocol enough could construct a tool to
find out what IP addresses are sharing a particular content (as with
BitTorrent). However, it is _not_ possible to target specific IPs and get a
list of all the resources shared by devices behind them.

## As a bridge

**Q6: As a bridge, can others find my IP address?**

Yes, every CENO browser able to communicate with injectors will register its
IP address in the BitTorrent's DHT where others can find them.

**Q7: As a bridge, is it possible I am helping someone to access content which is illegal in my country?**

Yes. However, bridges currently only relay encrypted communication between a
CENO user and one of the injectors. This means that a bridge shall never make
_direct_ HTTP requests to any other server on someone else's behalf.

----

# Feedback

As mentioned, we're currently in a testing phase and are happy to receive
positive and negative feedback as well as questions at <cenoers@equalit.ie>.

# Screenshots

Can be found in the [images/screenshots folder](images/screenshots)

# About eQualitie

![](./images/equalitie-logo.png "eQualitie logo")

[eQualitie][] develops open and reusable systems with a focus on privacy, online security, and information management.  Our goal is to create accessible technology and improve the skill set needed for defending human rights and freedoms in the digital age.

[eQualitie]: https://equalit.ie/
