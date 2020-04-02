# How does it work?

This section will explain CENO and Ouinet operation by going over a series of scenarios and explaining how they behave in each of them.  Main concepts and terms used by Ouinet will be introduced (highlighted **in bold letters**) and used afterwards for efficiency and to avoid confusions.

The CENO Browser is an example of an application which uses Ouinet technology to retrieve and share Web content.  We call such an application a Ouinet **client**.  When you use your client (i.e. CENO) to try to access some content *X*, hosted in some Web server which we call *X*'s **origin** server, your client tries to contact the origin server over the Internet either directly or via some other machine specialized in contacting Web servers on behalf of others, a so called **proxy** server, then request the desired content.  This is not different from the way in which any normal Web browser works.

> **Technical note:** There is in fact one small gotcha.  Since the client acts as an HTTP proxy running on your device, for the client to be able to decrypt and act upon HTTPS content requests, the application using it (i.e. the Web browser part) needs to accept a special certificate issued by the client itself (and only used in your device).  The CENO Browser already takes care of setting this certificate up for its private use so that you do not need to worry.

However these direct paths may not be available.  For instance, your Internet service provider (ISP) may be blocking access to *X*'s origin server or the proxy because of a state order (even if other traffic is still allowed).  As the user of the top left client depicted below, both attempts to reach content *X* (the little document close to its origin server) would fail for you.  We will come this weird "injector" node in a moment.

![Figure: User cannot reach content directly](images/user-flow-0.svg)

With a normal browser you would be out of luck.

TODO

![Content not found in the distributed cache](images/user-flow-1.svg)

![User reaches for injector](images/user-flow-2.svg)

![User receives signed content from injector](images/user-flow-3.svg)

![User receives signed content from client](images/user-flow-4.svg)

![User receives signed content from multiple clients](images/user-flow-5.svg)
