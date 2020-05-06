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

CENO is currently in BETA release. It is being tested in countries that censor large parts of the Internet from their citizens. We offer it with the best intention that it is useful to you, but due to its highly innovative nature and stage of development, you may expect some issues while using it. We will be submitting the codebase to an independent audit in the near future and will update this entry when that work is completed. 

# Warnings!

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

Please refer to the [Censorship.no! User Manual](user-manual/en/SUMMARY.md) for a detailed introduction to CENO and Ouinet, the concepts they rely upon, and how to use them.

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
internet websites. Please check [the User Manual][user-manual-risks] for a list
of risks in playing each of those roles.

[user-manual-risks]: user-manual/en/concepts/risks.md
    "Censorship.no! User Manual — Risks in using CENO/Ouinet"

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
