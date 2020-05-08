# Public vs. private browsing

Because of the many techniques to overcome connectivity issues, CENO may become a convenient way for you to get all kinds of Web content.  And, as you may have already read in previous sections, whenever you retrieve a page using the CENO Browser, it becomes available to others on the P2P network. There may be some content however that you do not wish to share, and fortunately CENO can help you in this instance as well.

The default mode when you launch the application is **public browsing**.  In it, CENO accesses Web content as described previously:

 1. Direct access is attempted.
 2. Failing that, the distributed cache is searched.
 3. Failing that, the content is requested via an injector (maybe via another client).

CENO also has a **private browsing** mode.  In it, the distributed cache is never searched, and injection is never attempted:

 1. Direct access is attempted.
 2. Failing that, an injector is contacted (maybe via another client) and used *as a normal proxy server*. Note that in this case, neither the injector nor your client updates the disitrbuted cache with your page.

The different behavior results in different characteristics.  Thus, in public mode:

 1. You have better chances to get Web content, and help others get that content (from you).
 2. Pages with dynamic content (e.g. updated in real time) may not work.
 3. Pages requiring authentication do not work (passwords and cookies are removed by the client).
 4. Some browsing activity may be leaked to other users.
 5. Some browsing activity may be leaked to injectors.
 6. You need to trust injectors to sign all content.

While in private mode:

 1. You have less chances to get Web content (some connectivity to international servers is required), and other CENO users cannot get the content from you.
 2. Pages with dynamic content may work.
 3. Pages requiring authentication may work (when your connection is protected by HTTPS, the injector does not see your passwords).
 4. Browsing activity is not leaked to other users.
 5. Limited browsing activity is leaked to injectors (with HTTPS, only the origin server name or address).
 6. You need not trust injectors (with HTTPS, usual certificate-based security still works).

As a conclusion: if you are using CENO to read the news, watch videos, browse Wikipedia and other static resources that are otherwise censored in your network, consider using the default *public browsing* mode. And if you want to login to Twitter or edit your Wordpress website, use *private browsing* mode.

Please read the section on [risks](risks.md) for a more detailed explanation.  Also note that your client can continue to operate as a bridge and a seeder (of other content) regardless of public or private browsing. We explain this in greater detail in the [Helping others](../browser/bridging.md) section of the manual.
