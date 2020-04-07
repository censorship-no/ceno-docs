# Risks in using CENO/Ouinet

As any sufficiently complex computing system, and especially such an innovative one, using the CENO Browser (and any Ouinet client in general) is not free from some risks.  In this section we will compile and describe them to help you understand their implications according to the different roles you may play when using CENO:

  - as a *user* browsing Web sites
  - as a *seeder* sharing content over the distributed cache that you previously visited
  - as a *bridge* allowing other users to reach an injector

## As a user

### Can bridges see my communication with the origin server?

No.  The only role of a bridge is to forward raw traffic between a client and an injector.  This communication is always encrypted and bridges do not have the private keys required to access the content of the communication.

### Can injectors see my communication with the origin server?

Yes and no.  When the user requests content [in public browsing mode](public-private.md), all private data is stripped away from the request by the client, and only then encrypted for and forwarded to the injector, which proceeds to decrypt it.

On the other hand, when the request uses private browsing mode, it is not modified by the client, and the whole communication is encrypted for the origin server.  This means that in this other case the injector cannot decrypt the content.

> **Technical note:**  Only `GET` HTTP requests are candidates for injection, with query parameters removed, along with all but a limited set of fundamental and privacy-preserving HTTP header fields.

### Can injectors see my IP address?

Yes.  However, injectors cannot distinguish whether a request came from a
CENO user or a bridge.  Thus requests going to the injector can not be reliably
assigned an originating IP addresses.

### Can my private data leak to the distributed cache?

Hopefully not.  As mentioned above, the CENO Browser tries hard to strip away any private data from any request for injection.  In addition, the injector does not itself do any seeding; in fact, its sole purpose is to sign content so that Ouinet clients can seed it.  This means that when the content comes back to the client, it is further analyzed, and if the origin server indicated that it is of private nature, CENO will not to seed it either.

Still, there could be cases of badly designed or malicious pages which may collect some information from you (like an email address in a form or some browser fingerprints using JavaScript) and stuff it in another link URL as normal path components (e.g. `http://example.com/subscribe/you@example.org`).  If you suspect that a page may be doing that, better be on the safe side and use private browsing for it.

TODO
