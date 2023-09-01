# Public vs. private browsing

Because of the many techniques used to overcome connectivity issues, Ceno may become a convenient way for you to get all kinds of Web content.  And, as you may have already read in previous sections, whenever you retrieve and seed a page using Ceno Browser, it becomes available to others.  There may be some content, however, that you do not wish to share (or you do not want to let others know that you are trying to or did retrieve), and fortunately Ceno can help you in this instance as well.

The default mode when you launch the application is **public browsing**.  In it, Ceno accesses Web content as described previously:

1. Direct access is attempted.
2. Failing that, the distributed cache is searched.
3. Failing that, the content is requested via an injector (maybe via another client).

Ceno also has a **private browsing** mode.  In it, the distributed cache is never searched, and injection is never attempted:

1. Direct access is attempted.
2. Failing that, an injector is contacted (maybe via another client) and used *as a normal proxy server*.  Note that in this case, neither the injector nor your client updates the distributed cache with your page.

The different behavior results in different characteristics.  Thus, in public mode:

1. You have better chances to get Web content, and help others get that content (from you).
2. Pages with dynamic content (e.g. updated in real time) may break in obvious or subtle ways.
3. Pages requiring authentication do not work (as passwords and cookies are removed by the client).
4. Some browsing activity may be leaked to other users (see [risks](risks.md)).
5. Some browsing activity may be leaked to injectors (see [risks](risks.md)).
6. You need to trust injectors to retrieve and sign Web content.

While in private mode:

1. You may not be able to access blocked Web content if international connectivity is too scarce; even if you could, other Ceno users would not get that content from you.
2. Pages with dynamic content will probably work.
3. Pages requiring authentication may work (when your connection is protected by HTTPS, the injector does not see your passwords).
4. Browsing activity is not leaked to other users.
5. Limited browsing activity is leaked to injectors (with HTTPS, only the origin server name or address).
6. You need not trust injectors (with HTTPS, usual certificate-based security still works).

In conclusion: if you are using Ceno to read the news, watch videos, browse Wikipedia and other static resources that are otherwise censored in your network, consider using the default *public browsing* mode.  And if you want to login to Twitter or edit your WordPress website, use *private browsing* mode.

Please read the section on [risks](risks.md) for a more detailed explanation.  Also note that your client can continue to operate as a bridge and a seeder regardless of public or private browsing.  We explain this in greater detail in the [Helping others](../browser/bridging.md) section of the manual.
