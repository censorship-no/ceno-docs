# Installing CENO

The CENO Browser can be installed via the following means:

  - [Google Play][ceno-gplay] (*CENO Browser* from *eQualitie*): the recommended source for most Android users.
  - [GitHub][ceno-gh]: for Android devices without Google Play.
  - [Paskoocheh][ceno-pask]: for users in countries blocking access to the previous channels.

[ceno-gplay]: https://play.google.com/store/apps/details?id=ie.equalit.ceno
[ceno-gh]: https://github.com/censorship-no/ceno-browser/releases
[ceno-pask]: https://paskoocheh.com/tools/124/android.html

CENO requires *no special permissions* to run.

> **Warning:** Please be *extremely skeptical* about installing the CENO Browser from sources other than the ones listed above.  Because of the application's nature, their potential users may become a target for all kinds of fake or manipulated versions used to violate the user's privacy or attack other CENO and Ouinet users.  If in doubt, please contact <cenoers@equalit.ie> before installing a suspicious app.

When you run CENO for the first time, you will be presented with a series of screens introducing some features generic to Firefox browsers.  Just scroll through them by pressing *NEXT* until you see a *Sign in to Sync* button and a *START BROWSING* link.  Firefox Sync has not been tested to work with CENO, so just push *START BROWSING*.

## Stopping CENO completely

Every time that you start the app a CENO icon will appear on your device's notification bar.  This icon represents the *CENO Browser service*, which is the part of CENO that runs permanently (even when you are not browsing) and allows other clients to use your device as a bridge and retrieve content from it at any time.

Since running such service uses network and processor resources, you may want to stop it whenever you are on the move (i.e. not connected to Wi-Fi or far from a charger).  Tapping on the notification attached to the icon will stop both CENO and its service at once (until you open CENO again).

![Figure: Tap on the notification to stop the CENO service](images/tap-stop.png)
