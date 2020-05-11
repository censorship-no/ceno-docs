# Frequently Asked Questions

## Usage

### Can the CENO Browser replace my current browser (Chrome/Firefox/Safari)?

Short answer: yes, at least for some non-critical browsing.

Since CENO is based on Mozilla Firefox for Android, it provides all the features that expected from a modern browser.  However, its reliance on Ouinet technology for retrieving web content may affect its operation in subtle ways (some of them potentially involving your privacy).

Also, since CENO and Ouinet are still under development, you may experience some instability.  That may also mean that backwards-incompatible changes are introduced which require you to uninstall the application or remove stored data (including bookmarks and site settings) before upgrading.

For important work on Web sites not subject to censorship, we recommend that you use a normal Web browser instead of CENO.  Please read the section on [risks](../concepts/risks.md) for more information.

## Can I use the CENO Browser to access Twitter, Facebook and Gmail?

Short answer: yes, by using private tabs.

Although CENO strives to provide a user experience as similar to normal Web browsing as possible, some of the techniques used to avoid network interference do not play well with such dynamic sites.  This is the case with CENO's default mode of operation (i.e. public browsing), since it strips down all private data (like passwords and cookies) from Web traffic to ensure that it does not leak to other untrusted CENO or Ouinet users.

To avoid this and enable the use of such dynamic sites in CENO, you can use private tabs (i.e. private browsing), which leave private data intact and keep connections to the sites encrypted and thus protected from everyone else.  However this requires that some direct or indirect path exists to reach those Web sites.

For further details, please check the section on the differences between [public and private browsing](../concepts/public-private.md).

## Privacy and security

### Will my device store content which I did not request?

Short answer: no.

CENO only shares content that you requested (using [public browsing](../concepts/public-private.md)).

Please note that a malicious Web site may still try to trick your browser into retrieving content from other sites without your knowledge so as to force your device to store and share it with other users.  Hopefully Firefox code already does a pretty good job in detecting and blocking such attempts, but you should still avoid visiting suspicious sites.

Read more about how your CENO Browser retrieves and shares Web content with others [here](../concepts/how.md).

### Can anyone see if I am using the CENO Browser to access censored Web sites?

Short answer: yes, with some technical knowledge and resources.

CENO is not an anonymity tool.  An attacker able to spy your network traffic can see content being requested from or served to another user from your device.  The attacker can also test whether you are sharing a particular content, although they cannot list all the contents that you are sharing.

However, content being retrieved into the network for the first time or using [private browsing](../concepts/public-private.md) will travel over encrypted connections.  See [how content retrieval works](../concepts/how.md) and the associated [risks](../concepts/risks.md) for more information.

## Resource usage

### Does the CENO Browser use a lot of data?

Short answer: more than your usual browser.

Whenever your CENO Browser serves content to another user or forwards their traffic, it is consuming an extra amount of data which depends on factors like how popular the content is, how big, and how well-connected your device is.  Sharing more content also implies more overhead.

Although Ouinet is much lighter in resources than other data-sharing applications, it can still result in increased data usage and fees.  We recommend keeping an eye on the app's data usage (under Android settings) and running CENO on Wi-Fi instead of mobile connections.

### Does the CENO Browser use a lot of battery on my device?

Short answer: more than your usual browser.

CENO and Ouinet use various techniques for different users to cooperate in avoiding network interference and outages.  Serving content to and forwarding traffic for other users consumes extra power.  Also, even when your device is not actively helping other users, it still needs to stay reachable over the network, which prevents the use of some energy-saving features.

The net result is that CENO may keep on draining your battery even when not in use.  Our tests have not shown power consumption hiking too much, but your mileage may vary.  When in need of battery, we recommend stopping CENO completely (it offers a convenient shortcut for this, see [here](../browser/install.md)).

### Do I need to be connected to Wi-Fi to use the CENO Browser?

Short answer: no, but we strongly recommend it.

Although CENO should work fine on a mobile connection, there are two reasons why we recommend using a Wi-Fi connection instead:

 1. CENO consumes an extra amount of data which may result in a higher phone bill (see above).
 2. Mobile connections often make reaching your device more difficult from the outside than Wi-Fi ones, thus decreasing the chances that you can help other users get content.
