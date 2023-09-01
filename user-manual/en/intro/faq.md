# Frequently Asked Questions

## Usage

### Can Ceno Browser replace my current browser (Chrome/Firefox/Safari)?

Short answer: yes, at least for some non-critical browsing.

Since Ceno is based on Mozilla Firefox for Android, it provides all the features that are expected from a modern browser.  However, its reliance on Ouinet technology for retrieving web content may affect its operation in subtle ways (some of them potentially involving your privacy).

Also, since Ceno and Ouinet are under continuous development, you may experience some instability.  That may also mean that backwards-incompatible changes are introduced which require you to uninstall the application or remove stored data (including bookmarks and site settings) before upgrading.

For important work on Web sites not subject to censorship, we recommend that you use your habitual Web browser instead of Ceno.  Please read the section on [risks](../concepts/risks.md) for more information.

## Can I use Ceno Browser to access Twitter, Facebook and Gmail?

Short answer: yes, by using private tabs.

Although Ceno strives to provide a user experience as similar to normal Web browsing as possible, some of the techniques used to avoid network interference do not play well with such dynamic sites.  This is the case with Ceno's default mode of operation (i.e. public browsing), since it strips down all private data (like passwords and cookies) from Web traffic to ensure that it does not leak to other untrusted Ceno or Ouinet users.

To avoid this and enable the use of such dynamic sites in Ceno, you can use private tabs (i.e. private browsing), which leave private data intact and keep connections to the sites encrypted and thus protected from everyone else.  However, this requires that network traffic from your device can reach those websites in some way.

For further details, please refer to the section on the differences between [public and private browsing](../concepts/public-private.md).

## Privacy and security

### Will my device store content that I did not request?

Short answer: no.

Ceno only shares content that you requested (using [public browsing](../concepts/public-private.md)).

Please note that a malicious website may still try to trick your browser into retrieving content from other sites without your knowledge so as to force your device to store and share it with other users.  While Firefox code already does a pretty good job at detecting and blocking such attempts, you should still avoid visiting suspicious sites.

Read more about how your Ceno Browser retrieves and shares Web content with others [here](../concepts/how.md).

### Can anyone see if I am using Ceno Browser to access censored Web sites?

Short answer: yes, with some technical knowledge and resources.

Ceno is not an anonymity tool.  An attacker able to spy on your network traffic can see content being requested from or served to another user from your device.  The attacker can also assess whether you are sharing a particular website, although they cannot list all the content that you are sharing.

However, content being retrieved into the network for the first time or using [private browsing](../concepts/public-private.md) will travel over encrypted connections.  See [how content retrieval works](../concepts/how.md) and the associated [risks](../concepts/risks.md) for more information.

## Resource usage

### Does Ceno Browser use a lot of data?

Short answer: more than your usual browser.

Whenever your Ceno Browser serves content to another user or forwards their traffic, it is consuming extra data depending on factors like how popular or large the content is, and how well-connected your device is.  Sharing more content also implies more overhead.

Although Ceno is much lighter in resources than other data-sharing applications, it can still result in increased data usage and fees.  We recommend keeping an eye on the app's data usage (under Android settings) and running Ceno while connected to Wi-Fi instead of using mobile data.

### Does Ceno Browser use a lot of battery on my device?

Short answer: more than your usual browser.

Ceno and Ouinet use various techniques for different users to cooperate in avoiding network interference and outages.  Serving content to and forwarding traffic for other users consumes extra power.  Also, even when your device is not actively helping other users, it still needs to stay reachable over the network, which prevents the use of some energy-saving features.

The net result is that Ceno may keep on draining your battery even when not in use.  Our tests have not shown power consumption hiking too much, but your mileage may vary.  When in need of battery, we recommend stopping Ceno completely (it offers a convenient shortcut for this, see [here](../browser/install.md)).

### Do I need to be connected to Wi-Fi to use Ceno Browser?

Short answer: no, but we strongly recommend it.

Although Ceno should work fine on a mobile connection, there are two reasons why we recommend using a Wi-Fi connection instead:

1. Ceno consumes an extra amount of data which may result in a higher phone bill (see above).
2. Mobile connections often make reaching your device more difficult from the outside than Wi-Fi ones, thus decreasing the chances that you can help other users get content.
