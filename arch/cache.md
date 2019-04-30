# Cache model

In an abstract sense, an **injector cache** is nothing more than a set of **URI descriptors** signed by the **signature key** of a particular **injector service**, so that there is one descriptor per cached URI.  In a sense, one would be able to recreate a particular service's cache by gathering all descriptors in the wild having a valid signature for this service, and then mapping each descriptor's URI to the descriptor itself.  Given two descriptors with the same URI, the one with an older date is simply discarded.

A URI descriptor itself is defined as a set of different versions of the data and metadata behind a URI (or set of equivalent URIs) which make sense as a whole according to a particular injector service.  Different injectors may follow different criteria to group versions and select metadata depending on their purpose.

Besides the *URIs* of the described resource and the *date* when the descriptor was created, the descriptor contains a list of *versions* of the cached resource.  Each item in the list contains the insertion date, metadata, length and hash of that version of the resource.  The descriptor may include a set of *data links* (either content-addressed, inline or location-addressed) for retrieving the data of each different version (by their content hash).  Finally, the descriptor contains a list of *signatures* from injector services, with each item including a signature key and the signature itself (with its date).  Compact signature keys like Ed25519 are thus preferred.  The signatures help clients validate descriptors against trusted injector services regardless of how they obtained them.

(Having several signatures for the same descriptor allows several injector services with similar purposes to cooperate in sharing efforts to publish cached content by "adopting" other's descriptors.  In any case, when publishing a descriptor to some network —see below— the publisher is free to remove or add signatures.)

> **B1a (Add support for URL descriptor documents):** This is supported by this proposal, with a dedicated key pair per injector service, and its publication is decoupled from its creation (see below).  The specific syntax and signature embedding is not specified, although [Matrix](https://matrix.org/docs/spec/appendices.html#signing-json "Matrix JSON signing") and [Peerkeep](https://perkeep.org/doc/json-signing/ "Peerkeep JSON signing") already offer an approach for JSON files.

> **B1b (Managing multiple versions of the same cached URL)**: URI descriptors provide the base for this although what constitutes a version is outside of the proposal itself and depends on the purpose of the injector service.

> **B4a (Broadcast support):** One example of "descriptor adoption" would be a broadcast content publisher creating its own descriptors with its own signature, only to be communicated by some means to some cooperating injector service that could add its own signature to them without actually getting to see the linked data.

## Cache storage

Since URI descriptors are self-contained and signed, they can use any kind of storage (online or offline, mutable or immutable, trusted or untrusted).  An injector service may make use of a **private data base** mapping cached URIs to their more recent descriptors.

Usually, the injector service will also make sure that URI descriptors conforming the cache are publicly available on several distributed storage back-ends like IPFS or BitTorrent, along with the data they refer to (see below).

> **A1b (Cooperation between injectors):** This data base may be concurrently updated by different injector hosts having access to signature keys.  Insertion triggered by requests to a single or different endpoints is decoupled from publishing (see below).

## Cache publication

Since scanning the different supported distributed storage back-ends to locate current URI descriptors is not generally feasible for clients, mechanisms are put in place to publish the cache as a **public data base**.  Each such mechanism must ensure that:

 1. The mapping of URI to URI descriptor is *certified by an authority* (to avoid the insertion, retrieval and use of fake descriptors), and only by that authority (e.g. a mapping cannot be replaced by another authority which still provides valid URI descriptor signatures for the same URI).
 2. The data base is *eventually consistent*, i.e. nodes may not always have the latest mapping, but when they know about a newer valid version they update it automatically (this reduces the impact of misbehaving nodes sticking to old mappings).
 3. A set of *data links* can be added to the URI to descriptor mapping to indicate additional ways for retrieving data (managed by the publisher instead of injectors).

> **A1b (Cooperation between injectors):** A process separated from private data base insertion (handled by injector hosts) can take snapshots of it for publication (with the desired degree of consistency).

> **D1a (Multiple independent cache implementations):** The decoupling of the private data base and the different public data bases published via different back-ends is what enables this objective.

> **D2 (New caches):** They are enabled by this decoupling.

An example of such mechanism is an [ipfs-cache](https://github.com/equalitie/ipfs-cache/) instance where an IPNS address points to a JSON data base mapping each URI to the IPFS address of its descriptor and data links (transitively certifying all mappings and links since the pointed content is immutable).  Another potential implementation may use BitTorrent's [BEP44](http://bittorrent.org/beps/bep_0044.html) to create DHT entries mapping a public key hash plus a URI-based salt to mutable content signed by the matching private key, pointing to the current URI descriptor and data links.

> **A2a (Dispersing data base mappings):** This approach does not deal with the dispersion of the private data base (which may use any distributed back-end), but with that of the public data base.  Some choices like BEP44 implicitly allow geographically distributed and concurrent update of mappings.  More centralized choices like IPNS may play different roles like supporting backups or replicas (which BEP44-based choices may not support).

Every injector service will usually run a **cache publisher** service to publish its own cache as a public data base via some of the previous mechanisms, and keep it available along with the data linked by it, either directly from some **cached data storage** or with the help of other nodes.  Other publishers may decide to republish entire or partial versions of an injector service's cache (e.g. in the interest of publishing a single site, avoiding certain sites, or merging different caches).

> **B3a (Altruistic seeding):** The "help of other nodes" for keeping data available is a provision for this objective.

Each publisher may rely on its own back-end specific public/private key pairs not related with the injector service's signature key.  If the back-end and the publisher offer enough trust to a client, it might choose not to check injectors' signatures on descriptors.  Otherwise, since URI descriptors are signed and include data content length and hash, less reliable back-ends like uncertified DHT mappings or even plain files on a USB stick or some broadcast media might be used, and a client may still validate data.

> **A3a (Geographical preference of peers):** Certain publishers may republish the cache in geographically-aware ways (e.g. broadcast, in-country HTTPS servers…).

> **A3b (Support for injectors subject to limited censorship):** Certain publishers may offer filtered versions of the cache.

> **B4a (Broadcast support):** Another approach is having a publisher which merges the cache from some injector service with that of a broadcast content publisher.

> **D3a (Distributed cache resistance to blocking)**: This is eased by having different back-ends and unrelated republishers of the cache, possibly enabled by replica-amenable back-ends like `ipfs-cache`.

As a summary, while an injector service certifies the data and metadata of a set of URIs, a cache publisher certifies different ways to retrieve the previous information.

## Cache insertion

Insertion into the cache consists on the injector service creating and signing a new URI descriptor (or an updated version of it), probably following a request from a client to one of the **injector service's endpoints** via a Ouinet-supported transport (ouiservice).  Update of the service's private data base and publication of the new descriptor may be delayed as necessary for diverse purposes.

## Injector service description

From the description above follows that the information that needs to be conveyed for a user to make use of an injector service is:

  - *Injector's signature key*, e.g. an Ed25519 public key.
  - *Injector's ouiservice endpoints*, e.g. an I2P, GNUnet or HTTPS transport address.
  - *Public data base credentials*, e.g. an IPNS address or BEP44 public key (from the injector or some trusted publisher).

> **A4a (Dynamic and decentralized ouiservice endpoint distribution):** This is still orthogonal to this proposal but it includes what information should de distributed.
