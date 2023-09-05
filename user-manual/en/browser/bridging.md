# Helping other Ceno users browse the Web

A peer-to-peer network is built from every node connected to it (yes, that means you as well!).  The more nodes, the stronger and more versatile the network becomes.  If you are running Ceno Browser from a country that does not censor the Internet (or not as heavily as some), consider helping other Ceno users by becoming a **bridge** node.  You will then begin to route traffic between clients living in heavily censored countries and Ceno injectors.  You will not be able to see their traffic (it will be sent through an encrypted tunnel), nor will any of this traffic remain on your device.

> **Note:** The configuration described in this section may also help your device to effectively seed content to others on the distributed cache, so please consider applying it as well when using Ceno in a censoring country (but keep in mind the [risks](../concepts/risks.md) of serving such content to others).

## How to become a Ceno bridge

This functionality is already built into Ceno Browser.  Your device will need to be connected to a Wi-Fi network that has either UPnP enabled or explicit port forwarding configured for Ceno.  See the next sections for further details.

However, please note that Android will only allow a mobile device to act as a proper bridge while you are actively using it, as power-saving features will throttle the operation of Ceno otherwise.

> **Technical note:** This is mainly due to Android's [Doze mode][] slowing down the operation of the native Ouinet library.  Unfortunately, disabling battery optimization for Ceno does not seem to exclude Ouinet from it.  Your particular device may also include its own power-saving features which may interfere with Ceno; please check [Don't kill my app!][] for your device's brand.

[Doze mode]: https://developer.android.com/training/monitoring-device-state/doze-standby
    "Android Developers – Optimize for Doze and App Standby"
[Don't kill my app!]: https://dontkillmyapp.com/

Thus if you intend to have Ceno acting as a permanent, always-reachable bridge, besides a properly configured Wi-Fi network you will need to:

1. Have your device plugged in to power at all times.
2. Have the device's screen on at all times.

   One convenient way of doing this without much power consumption and obnoxious, permanent lighting is using Android's screen saver: enable it under *Settings / Display / Screen saver* (or *Daydream* in some versions), pick the *Clock* widget, choose *When to start screen saver* in the menu and select *While charging* or *Either*.  A very dimmed down clock will appear on a black background while the device is not active.

   Please note that you should not use the power button to lock the device as this will turn the screen off.  Instead, just wait for the device to lock itself with the screen on.

If that setup is not an option for you, do not desist yet!  If you have a computer with good connectivity that stays on most of the time, please continue reading.

## Running a bridge on a computer

If your computer supports [Docker containers][docker], you can run a pre-configured Ceno client on it to act as a bridge.  If Docker is not yet installed, please follow the instructions to [install the Docker Engine][docker-install] in your platform.  For Debian derivatives like Ubuntu or Linux Mint, you can just run: `sudo apt install docker.io`

[docker]: https://en.wikipedia.org/wiki/Docker_(software)
[docker-install]: https://docs.docker.com/engine/install/

To deploy a Ceno client container you only need to run the following command on a terminal (it looks scary but you can just copy and paste it as is on the command line):

```sh
sudo docker run --name ceno-client \
  -dv Ceno:/var/opt/ouinet --network host \
  --restart unless-stopped equalitie/Ceno-client
```

If your computer is not based on GNU/Linux, the command needs to be slightly different:

```sh
sudo docker run --name ceno-client \
  -dv ceno:/var/opt/ouinet \
  -p 127.0.0.1:8077-8078:8077-8078 -p 28729:28729/udp \
  --restart unless-stopped equalitie/ceno-client
```

The command will start a container named `ceno-client` that will run on every boot unless you explicitly tell it to stop.  Please check the [Ceno Docker client documentation][ceno-client-doc] for more information on how to manipulate the container.

[ceno-client-doc]: https://gitlab.com/censorship-no/ceno-docker-client#running-the-client

> **Note:** This client has no *Ceno Settings*: when instructed below to access that page, open instead the [client front-end](../client/front-end.md), which contains mostly equivalent information.

## Enabling UPnP on your Wi-Fi router

[UPnP][] is the easiest way of making your Ceno Browser (or computer client) reachable to the Ceno network.  The [Ceno Settings](settings.md) page will indicate the UPnP status on your local network.

> **Note:** Enabling UPnP on the Wi-Fi router may expose devices on your network to external interference.  Please make yourself [aware of the risks][upnp-risks] and also consider using alternative methods as explained below.

[UPnP]: https://en.wikipedia.org/wiki/Universal_Plug_and_Play
[upnp-risks]: https://www.howtogeek.com/122487/htg-explains-is-upnp-a-security-risk

A status like the one below indicates that UPnP is not available or not working on your WiFi router:

> **Reachability status**
>
>     undecided
>
> **UPnP status**
>
>     disabled / inactive

The status below indicates that UPnP is likely working and Ceno is currently verifying connectivity:

> **Reachability status**
>
>     undecided
>
> **UPnP status**
>
>     enabled

The status below indicates that UPnP is working and you can bridge connections for other Ceno users:

> **Reachability status**
>
>     likely reachable / reachable
>
> **UPnP status**
>
>     enabled

> **Note:** Even if UPnP is working, your router may still not be reachable from the outside.  This can be the case when *Ceno Settings* reports *External UDP endpoints* which look like [CGNAT][] addresses `100.X.Y.Z:N` with X between 64 and 127 (increasingly common among home ISPs), or like private addresses `10.X.Y.Z:N`, `172.X.Y.Z:N` with X between 16 and 31, and `192.168.X.Y:N`.  If so, please contact your ISP or network administrator to get a public address on your router or to establish port forwardings to the external endpoint.

[CGNAT]: https://en.wikipedia.org/wiki/Carrier-grade_NAT

There are many Wi-Fi routers on the market and each has their own particular features.  Herein a list of some manufacturers' instructions for enabling UPnP:

- [Linksys](https://www.linksys.com/us/support-article?articleNum=138290)
- [D-Link](https://eu.dlink.com/uk/en/support/faq/routers/wired-routers/di-series/how-do-i-enable-upnp-on-my-router)
- [Huawei](https://consumer.huawei.com/ph/support/content/en-us00275342/)
- [Xfinity](https://www.xfinity.com/support/articles/configure-device-discovery-for-wifi)
- [TP-Link](https://community.tp-link.com/us/home/kb/detail/348)
- [Netgear](https://kb.netgear.com/24306/How-do-I-enable-Universal-Plug-and-Play-on-my-Nighthawk-router)
- [Ubiquiti](https://www.geekzone.co.nz/forums.asp?forumid=66&topicid=205740&page_no=5#1725168)

## Using port forwarding as an alternative to UPnP

Instead of enabling UPnP on your router, you can create a port forwarding rule to make sure that connections from the Ceno network are forwarded to your device.  You will need to login to the router's administrative interface and locate the *port forwarding* option.  To see which IP address you need to forward the connections to and the relevant port, open the *Ceno Settings* page and look under the *Local UDP endpoints*.

> **Local UDP endpoints**
>
>     192.168.1.132:28729

The port forwarding must be for the UDP protocol (not TCP).  Ceno chooses a random port on first run and keeps it for subsequent runs, but your device's local network IP address may change from time to time.  Thus you should periodically review the *Ceno Settings* page to see that your device is reachable to the Ceno network.

> **Technical note:** Alternatively, you can make sure that the router always assigns the same IP address to your device (e.g. via a static DHCP lease for the device's MAC address).
