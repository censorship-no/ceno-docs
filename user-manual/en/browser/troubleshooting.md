# Troubleshooting

This section will give you some hints about what to do when different, known problems arise with CENO and Ouinet.  Please bear in mind that these are experimental projects, and that their operation is subject to a multitude of factors beyond our control, like the particular configuration and status of network infrastructure, as well as which content other users have retrieved and the characteristics of their connections.

If problems still persist, please report them to <cenoers@equalit.ie>.  We will try to help you with them.

## There is no CENO entry in the app menu

The CENO Extension may still be loading.  Please be patient.

## All widgets are grayed-out in the *CENO Settings* page

The CENO Extension has loaded, but it has not yet been able to retrieve status from Ouinet.  Since it may take a moment for Ouinet to be ready, please be patient.

If the Settings page stays like that after more than two minutes, Ouinet may have encountered some issue while starting.

Try to visit some page, if possible one which is usually available.  If you get an error like "Failed to retrieve the resource (after attempting all configured mechanisms)", CENO may be experiencing some issues with general connectivity (like being unable to join the BitTorrent network).  If you are on a mobile connection, try again with Wi-Fi.

If you get an error like "The proxy server is refusing connections" when visiting the page, try to stop other applications which may be offering some service to the device, then restart CENO.

> **Technical note:** This may happen if another application is already listening on TCP ports `127.0.0.1:8077` or `127.0.0.1:8078`.

## Accessing some content shows "Failed to retrieve the resource"

This means that CENO tried all available mechanisms to access the content, but none of them succeeded.

You should make sure that the following requirements are fulfilled for CENO to work:

  - You are running a recent version of the CENO Browser.  Obsolete versions may not be able to communicate with newer injectors or other clients.  Check the [installation instructions](install.md) to know where to get new versions.
  - All access mechanisms in the [Settings page](settings.md) are enabled.  Otherwise CENO will not be able to circumvent some connectivity issues when accessing content.
  - Your device has a working connection to the network, i.e. your normal Web browser is able to open some Web sites.  CENO and Ouinet cannot work when all network connectivity is shut down (although users may still find a common Wi-Fi access point to do device-to-device sharing).

If that is the case, it is worth explaining what may be happening for all access mechanisms to fail, so that you get an idea of the chances that you have to get the content.

### Origin access

Your CENO Browser cannot directly reach the content's origin server.  Either the server is having some difficulties itself (e.g. it is down or under some attack), or someone is interfering with your connection to it.

This is the main use case for CENO and the other mechanisms should compensate for it.

### Proxy/Injector access

TODO

### Distributed cache

TODO

## Others cannot retrieve content seeded by my device

First, make sure that your device is still seeding the content by going to the [*CENO Settings* page](settings.md), only leaving the *Distributed cache* box checked, then accessing that content again: it should load (at least partially), and pushing the CENO address bar icon should only show non-zero values under *Distributed cache* or *Local cache*.

If the content does not load, it could be that CENO has already removed it, since it automatically cleans up stale content (older than a week by default) from your local cache.  Enable *Injector access* in the Settings page and access the content again.  Please allow a couple of minutes to pass for the device to announce the content in the distributed cache index.  Disable *Injector access* and access the content again; if it still does not load, it may be that the particular content is not deemed safe for sharing by Ouinet (e.g. because the origin server precludes it or it requires authentication).

If the previous step works, but another device with *Distributed cache* on still shows "Failed to retrieve the resource…", there are two possible scenarios.  If both devices are in the same network (e.g. on the same Wi-Fi access point), it could be that the network does not allow direct communication between devices connected to it.  This happens in some public Wi-Fi networks, so try using a private one.

If the devices are in different networks, it could be due to a variety of reasons.  One of them is that the network of the first device does not allow incoming connections: if you open its *CENO Settings* page, under *Reachability status* it should say *reachable* or *likely reachable*.  Otherwise seeding may not be possible from that network as it is.

> **Technical note:** If your device reports *undecided* reachability and you can change the configuration of the access point, there is one more thing you can try: create a permanent port redirection from the port shown in the device's *CENO Settings* page, under *Local UDP endpoint(s)* to the address and port reported there.  CENO chooses a random port on first run and keeps it for subsequent runs, so you should just make sure that the access point always assigns the same IP address to the device (e.g. via a static DHCP lease for the device's MAC address).
