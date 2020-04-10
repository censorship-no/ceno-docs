# CENO settings

The CENO Browser allows you to change some Ouinet-specific settings and get information about your client in a simple manner.  This should not be needed for normal operation, but it may be useful to help test different strategies against network interference, and to report issues with the app.

> **Technical note:** These options are provided by the *CENO Extension*, a Firefox extension which comes installed out of the box with CENO and takes care of proper integration with Ouinet like enabling content injection and cache retrieval under public browsing, hinting the user about the source of the content being visualized, and warning about new versions of Ouinet.

These features are available in a page that can be accessed by choosing *CENO* in the app's main menu.  Please note that the menu entry may take a few seconds to pop up on app start.  The page should look like this:

![Figure: The CENO Settings page](images/settings.png)

## Choosing access mechanisms

The four check boxes on the top of the page selectively enable or disable the different mechanisms that CENO as a Ouinet client uses to retrieve content:

  - **Origin access:** When enabled, this allows CENO to try to reach the origin server directly.

    In case that getting most Web content is not particularly slow or expensive, direct access may be more than enough for most of the cases.  However, such direct connections may be tracked by your ISP or government.  Disabling this option may avoid such connections and trivial tracking to some extent (but not completely, see [risks](../concepts/risks.md)).

    Also, when accessing a Web site over insecure HTTP (instead of the more secure HTTPS), a censor may intercept the connection and supply the user with a bogus site, a tampering which CENO cannot detect by itself.  In such case it may help to disable this option and thus always resort to other, safer CENO mechanisms.

  - **Proxy access:** This option allows CENO to use injectors as normal proxy servers whenever content is not intended to be injected (e.g. in private browsing mode).  If other mechanisms are not used, requests shall be routed through bridges and injectors and, if using HTTPS, encrypted in such a way that only the origin servers can decrypt them.

    Please note that disabling both origin and proxy access will render private browsing useless.

  - **Injector access:** This option enables CENO, for requests made in public browsing mode, to strip any private information and send them to an injector.  The injector shall get the content from an origin server, sign it and send it back to CENO, which shall start seeding it.

  - **Distributed cache:** This allows CENO to try to retrieve content from the distributed cache (i.e. from other CENO and Ouinet clients seeding it).

> **Warning:** Please note that CENO does not yet remember these settings after restarting the app.  If you require some of the previous mechanisms to be off while using CENO, please remember to open the Settings page whenever you start the app and uncheck their boxes before browsing.  Sorry for the inconvenience.

## About your app

The page also provides you with some information about your CENO Browser app and Ouinet client:

  - *CENO Browser* indicates the exact version of CENO that you are using.  Please include this information in your issue reports.
  - *Ouinet* shows the version of Ouinet backing CENO.  Also include in reports.
  - *CENO Extension* shows the version of the extension that integrates Firefox with CENO.  Also include in reports.
  - *Local UDP endpoint(s)* are the Internet addresses used by CENO to seed signed content to other clients.  These are shown to help test and debug the app, and should not be generally disclosed.
  - *UPnP status* indicates whether CENO was able to tell your router or access point to allow incoming connections towards it.  Also include in reports.
  - *Reachability status* indicates how likely it is for your device to be able to effectively seed content to other clients.  Also include in reports.

## Collecting log messages

At the bottom of the page there is an *Enable log file* check box that allows you to collect all of Ouinet's internal messages and download them to a file.  This should only be used when diagnosing some problem in CENO; just follow these steps:

 1. At the CENO Settings page, check *Enable log file*.
 2. Go back to browsing and do whatever actions that trigger the troublesome behavior.
 3. Return to the CENO Settings page and click on the *Download* link next to the *Enable log file* check box.  Save the file for later use.
 4. Uncheck *Enable log file* to avoid the logs from growing too large.

Now you can use the saved log file to document an issue report, but try to avoid making it public since it may contain sensitive information about your browsing.
