# Public vs. private browsing

Because of all the techniques offered by Ouinet to overcome connectivity issues, CENO may become a convenient way to get all kinds of Web content.  And, as you may have noticed, whenever you inject a page using the CENO Browser, its content becomes available to others (either from your device or from others that got it from yours).  There could be some pages though which you may not wish to share with others, or let them know that you visited or are trying to visit.  Fortunately, CENO can help you with a special mode of operation.

The default mode when you launch the application is **public browsing**.  In it, CENO accesses Web content as described previously:

 1. Direct access is attempted.
 2. Failing that, the distributed cache is searched.
 3. Failing that, the content is requested via an injector (maybe via another client).

CENO also has a **private browsing** mode.  In it, the distributed cache is never searched, and injection is never attempted:

 1. Direct access is attempted.
 2. Failing that, an injector is contacted (maybe via another client) and used *as a normal proxy server*.

The different behavior results in different characteristics.  Thus, in public mode:

 1. You have better chances to get Web content (even under complete blocking), and help others get that content (from you).
 2. Pages with dynamic content (e.g. updating in real time) may not work.
 3. Pages requiring authentication do not work (passwords and cookies are removed by the injector).
 4. Some browsing activity may be leaked to other users.
 5. Some browsing activity may be leaked to injectors.
 6. You need to trust injectors to sign all content.

While in private mode:

 1. You have less chances to get Web content (some connectivity is required), and others cannot get it from you.
 2. Pages with dynamic content may work.
 3. Pages requiring authentication may work (with HTTPS, the injector does not see your passwords).
 4. Browsing activity is not leaked to other users.
 5. Limited browsing activity is leaked to injectors (with HTTPS, only the origin server name or address).
 6. You need not trust injectors (with HTTPS, usual certificate-based security still works).

Please read the section on [risks](risks.md) for a more detailed explanation.  Also note that your client can continue to operate as a bridge regardless of public or private browsing.

So as a rule of thumb, one would use public mode to browse news, watch videos, read documentation and other mostly static content, while private mode would better fit more dynamic content or authenticated Web applications like mail, chat or social networking platforms.
