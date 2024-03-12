<img src="images/logo_color.png#gh-light-mode-only" width=250px alt="Ceno Browser logo">

This is the repository for the Ceno Browser User Manual. Ceno (short for [Censorship.no!][]) is a mobile Web browser using a novel approach to circumvent Internet censorship infrastructure, allowing users living in a censored zone to share retrieved content with each other, peer to peer. 

[Censorship.no!]: https://censorship.no/

Ceno users do not need to know a friendly proxy server in an uncensored zone in order to bypass local filtering — setting Ceno apart from most other circumvention initiatives.  Ceno is built in expectation of aggressive Internet filtering and the establishment of [national intranets][] to fence off nations from the Web.

[national intranets]: http://en.wikipedia.org/wiki/National_intranet

Ceno is based on [Firefox for Android][] (a.k.a. Mozilla Fennec), extended to make use of the innovative [Ouinet library][], which allows web content to be served with the help of an entire network of cooperating nodes using peer-to-peer routing and distributed caching of responses.

[Firefox for Android]: https://www.mozilla.org/firefox/android/
[Ouinet library]: https://github.com/equalitie/ouinet/

For a user-level introduction to Ceno and Ouinet, the concepts they rely upon, and how to use them, please refer to the [Censorship.no! User Manual][].

[Censorship.no! User Manual]: https://censorship.no/user-manual/en/

For a technical-level, full specification of the Ouinet network, its components and protocols, please refer to the [Ouinet white paper][].

[Ouinet white paper]: https://github.com/equalitie/ouinet/blob/master/doc/ouinet-network-whitepaper.md

The *Censorship.no!* project is run by [eQualitie][] in support of Articles 18, 19 and 20 of the [Universal Declaration of Human Rights][].  Please contact <Cenoers@equalit.ie> in case of doubt or for further information.

[eQualitie]: https://equalit.ie/
[Universal Declaration of Human Rights]: https://www.un.org/en/universal-declaration-human-rights/

# Local Development

### System setup


1. Install ```mdpo``` dependency: 

    ```pip install mdpo==0.3.79```

    Tested with [mdpo](https://mdpo.readthedocs.io/) v0.3.79 (not newer, because of [mdpo#221](https://github.com/mondeja/mdpo/issues/221)), at least v0.3.68 is needed (to fix ["mdpo#164](https://github.com/mondeja/mdpo/issues/164)) - NOTE: This PR was finally merged in late 2023!.

2. Install fork of ```mdbook``` with rtl-support:

    ```
    apt install cargo rustc
    git clone -b rtl https://github.com/cN3rd/mdBook.git /path/to/mdbook
    cd /path/to/mdbook
    cargo build
    PATH=$PATH:/path/to/mdbook/target/debug
    ```

3. Clone ```ceno-docs``` (the user manual source) and ```ceno-website``` (the website source) to the same directory:

    ```
    git clone git@gitlab.com:censorship-no/ceno-docs.git
    git clone git@gitlab.com:censorship-no/ceno-website.git
    ```


### Update English templates and translation files:

1. Enter the ```ceno-docs``` directory and modify the strings in ```user-manual/en``` as needed and commit the changes to the master branch

2. Once strings in the ```user-manual/en``` markdown files are ready for translation, no-ff merge ```master``` into the ```um-i18n``` branch:

    ```
    git checkout um-i18n
    git merge --no-ff master
    ```

5. After merging, regenerate the English templates in ```user-manual/en.pot```:

    ```
    rm -rf user-manual/en.pot
    cd user-manual
    ./pot-extract.sh
    ```

6. Commit the changes to @en.pot```:

    ```git commit -m "Extract POT files"```

7. Now you can create new components in Weblate if needed; this will take care of adding new PO files

8. After generating the new POT files, PO files need to be updated so that Weblate sees the changes to msgids (as explained [here](https://docs.weblate.org/en/latest/faq.html#why-does-weblate-still-show-old-translation-strings-when-i-ve-updated-the-template)).

9. Update PO files for existing components, this will update PO files for all languages based on the new English templates: 

    ```./po-update.sh```

10. Commit modifications to PO files and push:

    ```
    git commit -m "Update PO files"
    git push origin um-i18n
    ```

11. Wait for translators to translate any new strings

12. Weblate pushes changes every 24 hours to their fork, [weblate/ceno-docs:weblate-censorship-no-user-manual](https://gitlab.com/weblate/ceno-docs/-/tree/weblate-censorship-no-user-manual), and it creates a [merge request to our ceno-docs repo](https://gitlab.com/censorship-no/ceno-docs/-/merge_requests) that must be approved before continuing to the next section.

## Generate new website source:

1. Make sure latest MR from ```weblate/ceno-docs:weblate-censorship-no-user-manual``` to ```um-i18n``` has been merged

2. Pull latest translations to your local clone:

    ```git pull origin um-i18n```

3. Generate new html/css pages for the user-manual:
    ```
    cd user-manual
    make clean
    make
    ```

4. Copy the newly generated user-manual to the ```ceno-website``` repo (which should be a clean checkout of ```origin/master``` branch in the same directory as ```ceno-docs```):
    
    ```make sync```

5. Commit any changes to ```um-i18n``` caused by make and merge them into ```master```:
    ```
    git commit -m "make changes to markdown files"
    git checkout master
    git merge --no-ff um-i18n
    ```

6. Push ```master``` and ```um-i18n```:

    ```
    git push origin master
    git push origin um-i18n
    ```

7. Push the user-manual update in ```ceno-website``` repo:
    ```
    cd ../ceno-website
    git add .
    git commit -m "Update user manual translations"
    git push origin master
    ```

# Where to get it

Ceno Browser is available [in Google Play](https://play.google.com/store/apps/details?id=ie.equalit.Ceno "Ceno app in Google Play"), [on F-Droid](https://f-droid.org/packages/ie.equalit.ceno/), [in Paskoocheh](https://paskoocheh.com/tools/124/android.html "Ceno app in Paskoocheh"), and [in Zanga.tech](https://zanga.tech/tools/166/android.html "Ceno app in Zanga.tech").  It is also available for direct download from [Gitlab](https://gitlab.com/censorship-no/ceno-browser/-/releases), [Github](https://github.com/censorship-no/ceno-browser/releases) and eQualitie's [dComms server](https://dcomm.net.ua/package/ceno/).

# Source Code 

Ceno is completely Free/Libre/Open Source Software.  If you are interested in its source code please check the following Git repositories:

  - Browser components: [package builder](https://github.com/censorship-no/Ceno-browser), [Firefox fork](https://github.com/censorship-no/gecko-dev/tree/Ceno), [included extensions](https://github.com/censorship-no/Ceno-distribution), [settings extension source](https://github.com/censorship-no/Ceno-ext-settings)
  - [Ouinet source](https://github.com/equalitie/ouinet)
  - Other project-related repositories: [Censorship.no! GitHub organization](https://github.com/censorship-no)

You may also be interested in the (no longer maintained) [previous incarnation of Ceno](https://github.com/censorship-no-archive/Ceno1), built on the [Freenet][] anonymous file sharing and content publishing network.  Other inactive project-related repositories can be found at the [Censorship.no! archive](https://github.com/censorship-no-archive).

[Freenet]: https://freenetproject.org/

# Operational Warnings
## Battery and data usage

To prolong availability of Ceno bridges, the Ceno browser shall continue working even when it goes to the background. We have not yet put in place functionality which would disable all networking operations when the device switches to cellular internet, nor when it is disconnected from the charger. 

Until we implement this functionality, to preserve the device battery and network bandwidth, users need to explicitly disable Ceno either by shutting it down from Android's list of running applications, or by tapping the "Tap to stop Ceno" button from the notification area.

## Ceno is not an anonymity tool

Ceno users should also be aware of the fact that Ceno is not a network to anonymize users such as Tor or I2P. More akin to BitTorrent, the IP addresses of users sharing particular content are visible to anyone who can understand the internal workings of the BitTorrent DHT protocol.

Information about your browsing might be leaked to other Ceno users, as well as the fact that your application is providing particular web content to others. Content accessed with the application may remain in storage in clear text for some time (continue reading for more information on this).  Other security or privacy-affecting issues might exist.

## Censorship circumvention will not always work

At the moment, Ceno relies on bridge nodes whose IP addesses are not banned by countries performing network censorship. We rely on people living outside the censored zone (this may be you!) running the Ceno client and acting as bridges to people inside the censored zone. Currently, in the event of a complete internet blackout where no data can pass through international boundaries, Ceno will cease to work.

The availability of web content (especially under censorship conditions) may vary widely depending on factors like website configuration, network capacity, and the presence, connectivity and browsing behavior of other Ceno users. The behavior of the mechanisms currently used to share content between users may be erratic.

In the future we're hoping to address these problems by:

1. Letting users "import" web content by means other than the Internet into a censored zone and disseminate it via decentralized content sharing protocols.
2. Modifying the protocol to find alternative routes to relay the traffic outside of the censored country and back (if one exists). 

# How does it work?

![Different ways of retrieving content over Ceno](./images/Ceno-access.svg)

When you access or *request* a web page using Ceno, the application first looks at the browser request to decide whether the page seems *cacheable*, i.e. potentially safe to be saved and publicly shared with other Ceno users (requests with authentication tokens, cookies or dynamic connections are not cached). Then it attempts to retrieve the page using several *mechanisms* until one of them succeeds:

  - It first attempts to retrieve the page straight from its **origin** (i.e. web server) as a normal browser would.
  - If that fails, and the page seems cacheable, the application tries to get it from the **distributed cache**, i.e. from other Ceno users that may have previously accessed it.  If it succeeds, the application itself starts sharing the page with other users.
  - If retrieving a cacheable page from the distributed cache fails, the application tries to retrieve it via an **injector**, a machine sitting in the uncensored zone which provides the application with the page content.  If the injector deems the *response* amenable to do so, it also provides additional information allowing users to share the page (which the application starts doing immediately).
  - If that fails, or if the page was not cacheable, the application uses the injector as a **proxy** to access content privately.  Neither the injector nor the application share the content publicly (in fact, when accessing secure web content, the injector is not even able to see the request and response themselves).

Users can selectively disable each of these mechanisms so that they are skipped altogether.  In the Ceno application menu, just select the *Ceno* entry and use the checkboxes corresponding to the different mechanisms.

# Caching

Once a particular piece of content has crossed the boundary to a censored zone, it is further distributed in a BitTorrent-like fashion. This has several advantages:

* Content remains accessible even after the censor shuts down international traffic completely.
* National traffic is often cheaper in censored countries, which may lead to decreased data costs.
* Device to Device communication (currently Wi-Fi only) may suffice in retrieving content.

# On content storage and availability

As you can see, your application will only be sharing *content that you have previously accessed*, and it will do that while it is running.  Conversely, if access to a page's origin or to the injector is not possible, the page will only be available if other users who have previously accessed the same page are still running the application.  The more users actively sharing a page, the more chances for other users to get it.

Content does not stay on your device forever.  After your application has stored more than 10 gigabytes (this is not configurable for the moment), content which has not been accessed for the longest time (either by you or other users via your application) is removed to make space for new content.

If you want to remove all stored pages, you can use the 'Purge Now' button located in the Ceno Settings page, or alternatively use the Panic Vutton option via your phone's notifications menu (TODO: Add Screenshots)

# Threat model

When the Ceno browser is started on a device, a number of internal IO processes are activated. The primary one - one that does not depend on any prior browsing - is that the app shall attempt to determine whether it can communicate with its configured injector servers. This operation is likely to fail in heavily-censored countries, but when it does NOT fail, the application becomes a bridge for others to reach injectors.

Another IO process that starts on app launch is content sharing of the distributed cache. This action depends on whether a user has used this Ceno browser in the past to view public websites through the injector. If so, that particular content shall be offered through BitTorrent's DHT network to others for download.

We call the former process "acting as a bridge" and the latter "acting as a seeder". In addition, we call "acting as a user" the process of users browsing internet websites. Please check [the User Manual][user-manual-risks] for a list of risks in playing each of those roles.

[user-manual-risks]: user-manual/en/concepts/risks.md
    "Censorship.no! User Manual — Risks in using Ceno/Ouinet"

----

# Feedback

As mentioned, we are happy to receive positive and negative feedback as well as questions at <Cenoers@equalit.ie>.

# Screenshots

Can be found in the [images/screenshots folder](images/screenshots)

# About eQualitie

<img src="images/equalitie-logo.png" width="200px" alt="eQualitie logo" href="https://equalit.ie">

[eQualitie][] develops open and reusable systems with a focus on privacy, online security, and information management.  Our goal is to create accessible technology and improve the skill set needed for defending human rights and freedoms in the digital age.

[eQualitie]: https://equalit.ie/
