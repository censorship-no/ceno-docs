# How does it work?

This section will explain Ceno and Ouinet operation by going over a series of scenarios.  Terminology and concepts important to Ouinet will be introduced (highlighted **in bold letters**) and used afterwards for efficiency and to avoid confusion.

## Accessing content directly

Ceno Browser is an example of an application that uses Ouinet technology to retrieve and share Web content.  We call such an application a Ouinet **client**.  When you use your client (i.e. Ceno) to try to access some content *X*, hosted on a Web server (which we will call *X*'s **origin** server), your client tries to contact the origin server over the Internet either directly or via some other machine configured to contact Web servers on behalf of others (a so-called **proxy** server) and then requests the desired content.  This is no different from the way in which any normal Web browser works.

> **Technical note:** There is in fact one small gotcha.  Since the client acts as an HTTP proxy running on your device, for the client to be able to decrypt and act upon HTTPS content requests, the application using the client (i.e. the Web browser part – like Firefox in Ceno) needs to accept a special certificate issued by the client itself (and only used on your device).  Ceno Browser already takes care of setting this certificate up for its private use so that you do not need to worry.

However, these direct paths may not be available.  For instance, your Internet service provider (ISP) may be blocking access to *X*'s origin server or the proxy because of a state order (even if other traffic is still allowed).  As the user of the top left client depicted below, both attempts to reach content *X* (the little document close to its origin server) would fail for you.  You may also note the "injector" node on the diagram.  We will explain that in a moment.

![Figure: Client cannot reach content directly](images/user-flow-0.svg)

With a normal browser you would be out of luck.  However, with Ouinet you can ask other clients for their copies of content *X*, should they already have a copy.  Let us see how Ouinet performs this request.

## Searching for shared content

The set of all content stored by Ouinet clients is called the **distributed cache**, i.e. a store which sits in no single place.  But how can your client find which other clients forming the cache have the desired content?

In any Web browser, to access content *X* it needs to know its [Uniform Resource Locator][] (URL), that is the address in the browser's location bar, e.g. `https://example.com/foo/x`.  From that URL, a normal browser would infer that it has to contact the Web server called `example.com` using the HTTP protocol (the language used to exchange Web resources) over SSL/TLS (a security layer over TCP, the Internet's rules for programs to talk to each other) and request the resource `/foo/x`.

[Uniform Resource Locator]: https://en.wikipedia.org/wiki/Uniform_Resource_Locator

Ouinet looks for the content in a different way.  It uses an index not unlike that of a book: in Ouinet's **distributed cache index** you look up the whole URL of the content and get a list of clients holding a copy of it.  The index itself is distributed, with clients in charge of announcing what content they have to others.  Actually, only a *hint* on each URL is announced, so that someone spying your device's traffic cannot tell which content you have, but someone looking for a particular content can follow the hints towards your client.

> **Technical note:** One way the index is implemented is using [BitTorrent][]'s [Distributed Hash Table][] (DHT) to get the addresses (IP and port) of the clients with the content.  The DHT uses a [Cryptographic hash function][] to compute the table key from the content's URL and some other parameters as the injector key (see below), so that several indexes can coexist.
>
> Also, Ceno Browser does not announce the URL of every single resource it holds: with any modern page having tens or hundreds of components (images, style sheets, scripts…), that would create a lot of traffic.  Instead, resources are grouped under the URL of the page pulling them, and only that URL is announced.  This is done with the help of an *ad hoc* browser extension (described later on).

[Cryptographic hash function]: https://en.wikipedia.org/wiki/Cryptographic_hash_function
[BitTorrent]: https://en.wikipedia.org/wiki/BitTorrent
[Distributed Hash Table]: https://en.wikipedia.org/wiki/Distributed_hash_table

Clients offering some particular content over the distributed cache are said to be **seeding** it or to be their *seeders* (these terms come from the P2P file-sharing world).  Going back to our example scenario, there are two clients seeding some content.  Unfortunately, one is seeding content *Y* and the other one content *Z*, so your client would find no entries for content *X* in the distributed cache index, as depicted below:

![Figure: Content not found in the distributed cache](images/user-flow-1.svg)

Fortunately, Ouinet offers a way to retrieve such content and furthermore make it available to other clients in the distributed cache.  Please read on to learn how.

## Sharing new content

### Proxies on steroids

In Ouinet, there are special kinds of proxy servers called **injectors** which sit in the (hopefully) free side of the Internet and try very hard to stay reachable despite blocking measures:

- First of all, connections between clients and injectors are encrypted (using standard SSL/TLS like in HTTPS) to avoid attackers from identifying injectors by eavesdropping on web traffic.

  By the way, injector certificates are shipped in Ceno Browser, allowing it to detect attackers trying to impersonate injectors.
- If encryption was not sufficient, connections to injectors can use special obfuscation techniques (like I2P and Tor's Pluggable Transports) to make identification even more difficult.
- Even if an injector was identified and access to it was blocked by your ISP, there are several of them and it does not matter which one your client contacts over the Internet.
- Some or all injectors may be blocked, but then the set of injectors can vary over time (with new ones being added).

  Your client need not know their Internet addresses in advance; instead, it performs a lookup in the **injector swarm** (another term from P2P file sharing), a single-entry distributed index similar to the distributed cache index which yields the addresses of currently available injectors.
- Finally, even if your client may not be able to reach any injector, some other clients may.  When a client is able to reach an injector and believes itself to be reachable by other clients, it becomes a **bridge** client and adds its own Internet address to the **bridge swarm**, another single-entry distributed index.

  So your client can look for such an address, connect to the bridge behind it and tell it to establish another connection to an injector on its behalf, creating a **tunnel** between your client and the injector.  Then a connection can be established between them inside of the tunnel.

  Please note that since client-to-injector connections are encrypted, bridges are not able to see the information flowing between them.

An injector can behave like a normal (though extra available) proxy server, and this is indeed what Ouinet clients (including Ceno Browser) do currently when trying to access content over a proxy.  In this case, the injector will neither see the actual information flowing between your client and the origin server (unless it is a plain, unencrypted HTTP connection itself).

But there exist other tools allowing you to reach proxies in stringent network interference conditions so, what is so special about Ouinet injectors?

### Trusting shared content

Well, the point is that an injector does not just retrieve content on behalf of your client, it also allows you to *share that content with others at a later time, even when there is no longer access to the injector or most of the Internet*.

You could of course download a page from your browser and copy the resulting files to other people, which should be fine if you know each other.  But what if you received such files from an unknown person?  How could you be sure that the content actually came from the website it claims to, that it was retrieved at a certain date or that the information in it was not manipulated?

We want Ceno and Ouinet usage to scale and provide as much content to as many people as possible, so we do want you to be able to receive content from people you do not know.  To enable you to accept such content, Ouinet uses **content signing**: your client is configured to trust content that is signed using a special key owned by injectors.  Whenever a client tells an injector to retrieve some Web content for sharing, the injector gets it from the origin server, uses the key to sign it, and returns the signed content to the client.

> **Technical note:** In fact, the injector signs individual blocks of data as they come, so even if the connection is cut in the middle while retrieving a big file, the downloaded data can still be shared by the client that received it.

Different injectors may have different keys, so you can choose which injectors to trust.  Picture it like this: you may trust a document signed by a *notary public* from your country, no matter who gave it to you (national or foreigner), while you would not be required to accept a document signed by a notary from another country.  Ceno Browser is already configured to trust a set of injectors run by eQualitie.

> **Technical note:** Injectors use a public/private key pair to create Ed25519 signatures; public keys are small enough to allow them to be sent along signatures, and encoded as 64 hexadecimal characters or 52 Base32 characters. They may even be exchanged on the phone or written down on a piece of paper.

### Content injection

Remember that in our example scenario your client had already tried to retrieve content *X* directly from the origin server and from other clients to no avail.  The client plays its last Ouinet card and tries to contact a trusted injector to get a signed copy of the content that it can share with other clients.

In the figure below you can see a possible outcome of that operation: the client first tries to contact the injector directly (e.g. using an Internet address that it got from the injector swarm), but sadly it is already blocked by your ISP; fortunately, the bridge swarm shows the Internet addresses for two other clients which are still able to reach an injector.  Your client opens a tunnel to the injector through one of these clients, so the injector gets the request for content *X* from your client, and asks its origin server for it.

![Figure: Client reaches for injector](images/user-flow-2.svg)

As content *X* is received by the injector, it signs it with its key, adds the signature to the content and sends it back to your client via the tunnel it arrived from (say, through the client sitting beyond the blocking).  Once the content reaches your client, it does three things:

1. It delivers it to you (in the case of Ceno, it shows the content on the browser).
2. It saves the content on your device for further seeding to other clients.  It will stay there for a configurable amount of time, or until you decide to clear all stored content.
3. It announces in the distributed cache index that it is in possession of a copy of that content, so that other clients can find it.

The whole combined operation of retrieval, signing, storage and announcement is what we call **content injection**, as shown in the figure below.

![Figure: Client receives signed content from injector](images/user-flow-3.svg)

## Browsing under complete blocking

Please note that the mechanism described above still requires that *some path exists* across blocking and towards the rest of the Internet.  But sometimes that path will also be missing: think about complete international disconnections, natural disasters, or simply excessive congestion of the few existing paths (due to everybody trying to go across them).  This is where the real power of the distributed cache comes into play.

Let us imagine that after you retrieved content *X* from the injector, a disaster leaves your region isolated from the world.  It turns out that content *X* becomes especially relevant since it describes some ways in which you can help your community in such a situation.

At that moment a second person using Ceno Browser also tries to get that content.  Access to the origin server or to anything beyond your region is impossible, so Ceno checks the distributed cache index for that content and it finds that your device is seeding it.  Ceno gets your Internet address from the index, connects to it and requests the content as shown below.

![Figure: Client receives signed content from client](images/user-flow-4.svg)

Now that second device also holds a copy of content *X*, so it announces this in the distributed cache index, thus becoming a seeder.  If a third person interested in that content uses Ceno Browser to retrieve it, Ceno will now see *two* addresses in the index for the content: your device's and that of the second user.  If the content is heavy (e.g. a video), this third device may try to get half of it from each of the other devices (as shown below), thus speeding up the download and reducing the traffic they use.

![Figure: Client receives signed content from multiple clients](images/user-flow-5.svg)

Finally, the situation may get even worse, and all commercial and state network infrastructure may be shut down.  In this case, Ouinet and Ceno Browser also have some support for *device-to-device* sharing of content between two clients sitting on the same local network (e.g. connected to the same Wi-Fi access point), even if the network has no access to others.
