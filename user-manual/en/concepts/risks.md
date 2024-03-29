# Risks in using Ceno/Ouinet

As with any sufficiently complex computing system, and especially such an innovative one, using Ceno Browser (and any Ouinet client in general) is not free from some risks.  In this section we will compile and describe them to help you understand their implications according to the different roles you may play when using Ceno:

- as a *user* browsing Web sites
- as a *seeder* sharing content over the distributed cache that you previously visited
- as a *bridge* allowing other users to reach an injector

## As a user

### Can bridges see my communication with the origin server?

No.  The only role of a bridge is to forward raw traffic between a client and an injector.  This communication is always encrypted and bridges do not have the private keys required to access the content of the communication.

### Can injectors see my communication with the origin server?

Yes and no.  When the user requests content [in public browsing mode](public-private.md), all private data (like passwords and cookies) is first removed from the request by the client, and only then is the request encrypted for and forwarded to the injector, which proceeds to decrypt it.

On the other hand, when the request uses Personal browsing mode, it is not modified by the client, but the whole communication is encrypted for the origin server.  This means that in this other case the injector cannot decrypt the content.

> **Technical note:**  Only `GET` HTTP requests are candidates for injection, with query parameters removed, along with all but a limited set of fundamental and privacy-preserving HTTP header fields.

### Can injectors see my IP address?

Yes.  However, injectors cannot distinguish whether a request came from a Ceno user or a bridge.  Thus requests going to the injector cannot be reliably assigned an originating IP addresses.

### Can my private data leak to the distributed cache?

Hopefully not.  As mentioned above, Ceno Browser tries hard to remove any private data (passwords, cookies…) from any request for injection.  In addition, the injector does not itself do any seeding; in fact, its sole purpose is to sign content so that Ouinet clients can seed it.  This means that when the content comes back to the client, it is further analyzed, and if the origin server indicated that it is of a private nature, Ceno will not seed it either.

Still, there could be cases of badly designed or malicious pages which may collect some information from you (like an email address in a form or some browser fingerprints using JavaScript) and stuff it in another link URL as normal path components (e.g. `http://example.com/subscribe/you@example.org`).  If you suspect that a page may be doing that, better be on the safe side and use Personal browsing for it.

### Can the origin server know whether I am using Ceno?

Most probably not.  Whenever Ceno contacts an origin server directly, it behaves as normal Firefox for Android does, so your particular device appears as a normal Firefox app of the same version.

However, when it uses an injector to get some content from its origin server, there are (at least) two ways for the latter to know that Ceno or Ouinet is involved:

1. The source address of the connection reaching the origin server is found in the injector swarm (since the connection comes indeed from the injector);
2. The presence or absence of certain information in the request for content is characteristic of Ouinet.  This happens when the injector is requesting the content because your client asked it to retrieve and sign that content, as the injector removes information unique to your particular device from the request.

Please note that these only mark the request as coming from Ouinet, but they do not link it to you or your particular device.  However, if the request did for some of the reasons mentioned in the previous question still contain some personally identifiable information, it could be used to mark you as a Ceno user.

In general, if a particular website (such as a governmental site) expects you to connect to it as an identifiable individual, from a specific region (or from a [national intranet][]), we recommend that you use a normal Web browser instead of Ceno.

[National intranet]: https://en.wikipedia.org/wiki/National_intranet

## As a seeder

### What data is seeded from my device?

Currently, the only content that is seeded by Ceno is any non-private Web content which was requested in public browsing mode.  This also means that users do not seed anything they have not accessed themselves in the recent past.

### Can an anyone find out what I seed?

Yes and no.  Anyone with enough understanding of Ouinet's operations could construct a tool to find out what IP addresses a particular content is being shared from (as with BitTorrent).  However, it is not possible to target a specific IP address and get a list of all the content seeded by clients behind it.

## As a bridge

### Can others find my IP address?

Yes, every Ceno Browser able to communicate with injectors will register its IP address in the bridge swarm where other Ouinet clients can find them.

### Is it possible that I am helping someone to access content which is illegal in my country?

Yes.  However, bridges only relay encrypted communication between a Ouinet client and an injector.  This means that a bridge shall never make direct requests for content to any other server on someone else's behalf.
