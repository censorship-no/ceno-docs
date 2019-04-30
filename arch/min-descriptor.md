% Minimal common descriptor format

This is a proposal for a minimal, common descriptor format to be used by both
IPFS and BEP44 implementations of the Ouinet distributed cache data base.

**Note:** The current proposal for BEP44 envisions a single descriptor inlined
in BEP44-mutable data, which has a maximum capacity of 1000 bytes (once
bencoded).  Since this proposal suggests embedding the HTTP response head in
the descriptor as metadata (I checked response headers to be generally under
700 bytes, with some exceptions over 1 KiB), the descriptor may need to be
compressed (although we may decide not to store many such non-standard
headers, mostly used for tracking).

The current implementation of the IPFS-based data base uses the following
descriptor format:

```json
{
    "body_link": "QmNYbA3z1NWzFZthEHszPMG1fvLBgXinEthfekYeF8drx3",
    "head": "HTTP/1.1 200 OK\r\nDate: Mon, 15 Jan 2018 20:31:50 GMT\r\nServer: Apache\r\nContent-Type: text/html\r\nContent-Disposition: inline; filename=\"foo.html\"\r\n\r\n",
    "url": "https://example.com/foo"
}
```

This proposal extends the format to the following one, shared by both IPFS and
BEP44-based data bases:

```json
{
    "ouinet_descriptor_version": 0,
    "uri": "https://example.com/foo",
    "uuid": "15bb4f34-ca7e-4f42-9b01-f147e9abcce9",
    "ts": "2018-01-15T21:31:44Z",
    "data_length": 38,
    "data_ipfs": "QmNYbA3z1NWzFZthEHszPMG1fvLBgXinEthfekYeF8drx3",
    "http_rph": "HTTP/1.1 200 OK\r\nDate: Mon, 15 Jan 2018 20:31:50 GMT\r\nServer: Apache\r\nContent-Type: text/html\r\nContent-Disposition: inline; filename=\"foo.html\"\r\n\r\n"
}
```

The rationale for each field being:

  - ``ouinet_descriptor_version``: This lets the descriptor format evolve by
    indicating which version of the format this descriptor is using.

  - ``uri``: This helps make the descriptor self-describing, since no further
    information on the request that caused its insertion is available, just
    the URI (``url`` in current ``master``).

  - ``uuid``: This is generated randomly by the injector on descriptor
    creation and helps identify a particular version uniquely and
    independently of the protocol used to retrieve the URI (e.g. HTTP).  Since
    the UUID is known before the whole descriptor is assembled, it can be
    later used by a client to verify that the descriptor retrieved in the data
    base corresponds to the version that it is seeding.

  - ``ts``: This indicates the moment when this resource was injected in the
    cache, since the data base may not have such time stamps (as is the case
    of BEP44).

  - ``data_length``: Not absolutely required, but it helps make decisions on
    the content, like synthesizing a ``Content-Length`` HTTP header if missing
    and then streaming the body.

  - ``data_ipfs``: An IPFS CID to get to the content.  IPFS is explicit in its
    name since the same descriptor format may be used with non-IPFS data bases
    (e.g. BEP44) (``body_link`` in current ``master``).

  - ``http_rph``: A verbatim dump of the HTTP response head, to reconstruct
    the HTTP response (``head`` in current ``master``).
