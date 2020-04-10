# Testing the Browser

Now that you know how to [install](install.md) and [configure](settings.md) CENO, let us follow some steps to test whether different Ouinet-specific features work.  This will involve selectively enabling and disabling different access mechanisms.  Keep in mind however that in day-to-day usage of CENO, you will seldom need to change the default settings at all.

For these tests you will need at least two devices connected to the same Wi-Fi network, and if possible a third one on a completely different network.

## Accessing an injector

Let us first check whether your CENO Browser can reach an injector.  This may look trivial but your client will already be exercising several Ouinet features in the process: looking up the injector address in the injector swarm, trying to contact it directly and, if it is blocked by your access provider or country, looking up the bridge swarm and trying to contact the injector via some other Ouinet client.

In the first device perform the following steps:

 1. First of all, install CENO if needed and start it.  On the first run a series of introductory screens will appear: just click on *NEXT* until *START BROWSING* appears, then click it.  In the end, Firefox's home page will appear.
 2. Open the app's main menu and choose *CENO* to open the *CENO Settings* window.  Since we only want to test injector access, uncheck the boxes for *Origin access*, *Proxy access* and *Distributed cache*.
 3. Go back to Firefox's home page.  Either select one of the recommended Web sites, or enter the URL of some other site at the address bar at the top of the window.  If you know about a site which is usually blocked for you, go ahead and enter it!
 4. The chosen site should eventually show up.

If the site does load, you can be happy that your device can reach the injector!  Since you are able to query swarms and contact other clients, you are also likely to be able to retrieve content from the distributed cache.

TODO
