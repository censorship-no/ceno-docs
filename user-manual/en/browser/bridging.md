# Helping other CENO users browse the Web

A peer-to-peer network is built from every node connected to it (yes, that means you as well).  The more nodes, the stronger and more versatile the network becomes.  If you are running the CENO Browser from a country that does not censor the Internet (or not as heavily as some), consider helping other CENO users by becoming a **bridge** node.  You will then begin to route traffic between clients living in heavily censored countries and CENO injectors.  You will not be able to see their traffic (it will be sent through an encrypted tunnel) nor will any of this traffic remain on your device.

> **Note:** The configuration described in this section may also help your device to effectively seed content to others on the distributed cache, so please consider applying it as well when using CENO in a censoring country (but keep in mind the [risks](../concepts/risks.md) of serving such content to others).

## How to become a CENO bridge

This functionality is already built into the CENO Browser.  Your device will need to be connected to a Wi-Fi network that has either UPnP enabled or explicit port forwarding configured for CENO.  See below for further details.

However, please note that Android will only allow a mobile device to act as a proper bridge while you are actively using it, as power-saving features will throttle the operation of CENO otherwise.

> **Technical note:** This is due to Android's [Doze mode][] slowing down the operation of the native Ouinet library.  Unfortunately, disabling battery optimization for CENO does not seem to exclude Ouinet from it.

[Doze mode]: https://developer.android.com/training/monitoring-device-state/doze-standby
    "Android Developers – Optimize for Doze and App Standby"

Thus if you intend to have CENO acting as a permanent, always-reachable bridge, besides a properly configured Wi-Fi network you will need to:

 1. Have your device plugged in to power at all times.
 2. Have the device's screen on at all times.

    One convenient way of doing this without much power consumption and obnoxious, permanent lighting is using Android's screen saver: enable it under *Settings / Display / Screen saver* (or *Daydream* in some versions), pick the *Clock* widget, choose *When to start screen saver* in the menu and select *While charging* or *Either*.  A very dimmed down clock will appear on a black background while the device is not active.

    Please note that you should not use the power button to lock the device as this will turn the screen off.  Instead, just wait for the device to lock itself with the screen on.

## Enabling UPnP on your Wi-Fi router

[UPnP][] is the easiest way of making your CENO Browser reachable to the CENO network.  The [CENO Settings](settings.md) page will indicate the UPnP status on your local network.

> **Note:** Enabling UPnP on the Wi-Fi router may expose devices on your network to external interference.  Please make yourself [aware of the risks][upnp-risks] and also consider using alternative methods as explained below.

[UPnP]: https://en.wikipedia.org/wiki/Universal_Plug_and_Play
[upnp-risks]: https://www.howtogeek.com/122487/htg-explains-is-upnp-a-security-risk

![Figure: UPnP not enabled](images/upnp-no.png)

A status like the one shown in the previous figure indicates that UPnP is not enabled on your WiFi router.

![Figure: UPnP likely enabled](images/upnp-maybe.png)

The status above indicates that UPnP is likely working and CENO is currently verifying connectivity.

![Figure: UPnP enabled](images/upnp-yes.png)

The status above indicates that UPnP is working and you can bridge connections for other CENO users.

There are many Wi-Fi routers on the market and each has their own particular features.  Herein a list of some manufacturers' instructions for enabling UPnP:

  * [Linksys](https://www.linksys.com/us/support-article?articleNum=138290)
  * [D-Link](https://eu.dlink.com/uk/en/support/faq/routers/wired-routers/di-series/how-do-i-enable-upnp-on-my-router)
  * [Huawei](https://consumer.huawei.com/ph/support/content/en-us00275342/)
  * [Xfinity](https://www.xfinity.com/support/articles/configure-device-discovery-for-wifi)
  * [TP-Link](https://community.tp-link.com/us/home/kb/detail/348)

## Using port forwarding as an alternative to UPnP

Instead of enabling UPnP on your router, you can create a port forwarding rule, to make sure that connections from the CENO network are forwarded to your device.  You will need to login to the router's administration interface and locate the *port forwarding* option.  To see which IP address you need to forward the connections to and the relevant port, open the *CENO Settings* page and look under the *Local UDP endpoint(s)*.

![Figure: Local UDP endpoints](images/udp-port.png)

The port forwarding must be for the UDP protocol (not TCP).  CENO chooses a random port on first run and keeps it for subsequent runs, but your device's local network IP address may change from time to time.  Thus you should periodically review the *CENO Settings* page to see that your device is reachable to the CENO network.

> **Technical note:** Alternatively, you can make sure that the router always assigns the same IP address to your device (e.g. via a static DHCP lease for the device's MAC address).
