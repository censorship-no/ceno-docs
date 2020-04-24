# What is the CENO Browser?

CENO (short for [Censorship.no!][]) is a Web browser for mobile devices (such as smart phones and tablets) which uses a novel approach to circumvent Internet censorship.  CENO allows to store Web content that the user visited on their device, and later deliver it to other CENO users who are unable to reach the servers of that content, either because of selective blocking or due to general shutdown of international connectivity.  The content is delivered from one device to the other over the network with no CENO-specific intermediaries (the so-called [peer-to-peer][P2P] or P2P fashion).

[Censorship.no!]: https://censorship.no/
[P2P]: https://en.wikipedia.org/wiki/Peer-to-peer

What sets CENO apart from most other circumvention initiatives is that users can continue to share Web content even when no (or extremely limited) connectivity exists across national borders, as long as it stays reasonably good in-country.  CENO is thus built in expectation of aggressive Internet filtering and the establishment of [national intranets][] to fence off nations from the Web.

[national intranets]: https://en.wikipedia.org/wiki/National_intranet

CENO is an adapted version of [Firefox for Android][], a popular, modern, feature-rich and secure Free/Libre/Open-Source browser.  CENO extends Firefox with **Ouinet**, the underlying technology allowing it to share content between devices (described in later sections).

[Firefox for Android]: https://www.mozilla.org/firefox/android/

## Who develops CENO?

The *Censorship.no!* project is run by [eQualitie][] in support of Articles 18, 19 and 20 of the [Universal Declaration of Human Rights][].  CENO and related technologies are developed as Free/Libre/Open-Source software ([project source][ceno-repos]), allowing anyone to use, study, share and enhance it.  Please contact <cenoers@equalit.ie> in case of doubt or for further information.

[eQualitie]: https://equalit.ie/
[Universal Declaration of Human Rights]: https://www.un.org/en/universal-declaration-human-rights/
[ceno-repos]: https://github.com/censorship-no/
    "CENO source code repositories"

## Who is it for?

CENO is specially convenient for people interested in Web content that may be targeted for censorship or other attacks by state or private actors, or for people who live in countries where connectivity to the global Internet is spotty, unreliable or more expensive.  It is also particularly useful for people willing to share interesting Web content with others, or to help others share such content.

One does not need advanced computer knowledge to use CENO: since it inherits the ease of use of Firefox (with CENO-specific functionality getting out of the way as much as possible), it feels like a normal browser.  Any person used to browsing the Web should feel comfortable with it.

CENO does however create more Internet traffic than your usual Web browser, since it needs to announce the Web content it is sharing, and possibly deliver it to other users that request it.  CENO thus relies on moderately good in-country connectivity.  For the moment, we recommend using CENO when connected to Wi-Fi to avoid exhausting mobile data limits and to increase the chances of being able to deliver content to other users.

**Warning:** *CENO is not an anonymity tool.*  In fact, using CENO may allow others to know whether you have accessed or are providing certain Web content.  Please take careful consideration of which risks you can assume by using this tool.  See the sections on [public vs. private browsing](../concepts/public-private.md) and [risks](../concepts/risks.md) for further information.
