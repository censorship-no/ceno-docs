# CENO settings

The CENO Browser allows you to change some Ouinet-specific settings and get information about your client in a simple manner.  This should not be needed for normal operation, but it may be useful to help test different strategies against network interference, and to report issues with the app.

These features are available in a page that can be accessed by choosing *CENO* in the app's main menu.  Please note that the menu entry may take a few seconds to pop up on app start.  The page should look like this:

![Figure: The CENO Settings page](images/settings.png)

The four check boxes selectively enable or disable the different mechanisms that CENO as a Ouinet client uses to retrieve content:

  - **Origin access:** When enabled, this allows CENO to try to reach the origin server directly.

    In case that getting most Web content is not particularly slow or expensive, direct access may be more than enough for most of the cases.  However, such direct connections may be tracked by your ISP or government.  Disabling this option may avoid such connections and trivial tracking to some extent (but not completely, see [risks](../concepts/risks.md)).

    Also, when accessing a Web site over insecure HTTP (instead of the more secure HTTPS), a censor may intercept the connection and supply the user with a bogus site, a tampering which CENO cannot detect by itself.  In such case it may help to disable this option and thus always resort to other, safer CENO mechanisms.

  - **Proxy access:** This option allows CENO to use injectors as normal proxy servers whenever content is not intended to be injected (e.g. in private browsing mode).  If other mechanisms are not used, requests shall be routed through bridges and injectors and, if using HTTPS, encrypted in such a way that only the origin servers can decrypt them.

    Please note that disabling both origin and proxy access will render private browsing useless.

  - **Injector access:** This option enables CENO, for requests made in public browsing mode, to strip any private information and send them to an injector.  The injector shall get the content from an origin server, sign it and send it back to CENO, which shall start seeding it.

  - **Distributed cache:** This allows CENO to try to retrieve content from the distributed cache (i.e. from other CENO and Ouinet clients seeding it).

TODO
