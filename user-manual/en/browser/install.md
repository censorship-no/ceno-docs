# Installing CENO

The CENO Browser can be installed via the following means:

- [Google Play][ceno-gplay] (*CENO Browser* from *eQualitie*): the recommended source for most Android users.
- [GitHub][ceno-gh]: for Android devices without Google Play.
- [Paskoocheh][ceno-pask]: for users in countries blocking access to the previous channels.

[ceno-gplay]: https://play.google.com/store/apps/details?id=ie.equalit.ceno
[ceno-gh]: https://github.com/censorship-no/ceno-browser/releases
[ceno-pask]: https://paskoocheh.com/tools/124/android.html

CENO requires *no special permissions* to run.

> **Warning:** Please be *extremely skeptical* about installing the CENO Browser from sources other than the ones listed above.  Because of the application's nature, their potential users may become a target for all kinds of fake or manipulated versions used to violate user privacy or attack other CENO and Ouinet users.  If in doubt, please contact <cenoers@equalit.ie> before installing a suspicious app.

## Stopping CENO completely

Every time you start the app, a CENO icon will appear on your device's notification bar.  This icon represents the *CENO Browser service*, which is the part of CENO that runs permanently (even when you are not browsing) and allows other clients to use your device as a bridge and retrieve content from it at any time.

Since running such service uses network and processor resources, you may want to stop it whenever you are on the move (i.e. not connected to Wi-Fi or far from a charger).  Tapping on the notification attached to the icon will stop both CENO and its service at once (until you open CENO again).

![Figure: Tap on the notification to stop the CENO service](images/tap-stop.png)

## Purging all CENO data (the "panic button")

The *CENO Browser service* notification shown above includes a few accompanying actions which can be triggered by tapping on them.  The *Home* action will just open CENO with a new public browsing tab showing its home page.  The *Erase* action demands more explanation.

> **Note:** If the actions below the notification are not visible, drag the notification from its center towards the bottom to unfold it.

Shall you ever need to quickly stop CENO and clear absolutely all data related to it (not only cached content, but also settings like favorites, passwords and all browsing history), you can tap on *Erase*.  To avoid losing your data accidentally, this will not remove anything yet, but just show an additional action for a brief moment, as pictured below:

![Figure: The last action stops CENO and clears all its data](images/tap-purge.png)

If you tap on the *Yes* action, CENO will be stopped and all its data removed *without further questions*, effectively leaving your device as if CENO had never been used.

If you do not tap on the action, it will go away in a few seconds.

> **Note:** The method described above requires that CENO be running on your device.  To accomplish the same effect when CENO is stopped, you can use Android's general *Settings* page and, under the *Apps* entry, choose CENO and then *Clear data*.
>
> As a harsher alternative, you may completely uninstall the app.

> **Warning:** Android may still keep other traces of having used an app besides its data, for instance in its system log.
