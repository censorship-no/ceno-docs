# Introduction

The Internet and the World Wide Web have become more and more important for people around the world as a source of all kinds of information, and a way to exercise fundamental rights.  At the same time, recent years have seen an increase in all kinds of network censorship and other types of network interference (see the reports from [OONI][ooni-reports], [Magma][magma-reports], [Censored Planet][cplan-reports]), both from private and state actors.

[ooni-reports]: https://ooni.org/reports/
    "Open Observatory of Network Interference — Research reports"

[magma-reports]: https://magma.lavafeld.org/publications/
    "Magma publications"

[cplan-reports]: https://censoredplanet.org/reports
    "Censored Planet — Reports"

The Web relies on your devices being able to reach special computers called *web servers* (run by content creators, publishers or Internet services providers) that hold the content which you want to retrieve, and to do so in a synchronized way, more like keeping a live chat on the telephone than exchanging some letters.  Unfortunately, this requires that the web server you need is connected to the network and has enough available resources to talk to your device at that moment.

The advent of *content delivery networks* (or CDNs, like the commercial Akamai and Cloudflare, or the civil society-oriented Deflect) has removed some of the load off these web servers by distributing copies of the content to data centers all over the world, so that it can be closer to your devices and thus faster to reach, while keeping the origin servers protected from direct accesses.  However, now CDN servers (thus the organizations that run them) need to be trusted by both the origin server and your devices, and they also need to be reachable at all times.

Unfortunately again, there are situations in which general connectivity is scarce (developing countries or underserved, impoverished or rural regions), expensive (with some countries charging more for international traffic) or has been actively blocked by an state player (explicitly or as a result of a general shutdown).  In these cases, reaching origin web servers or even CDN servers is difficult or impossible, and your device will not be able to get that content, even if I was somehow able to access it a few hours ago and we're living some streets apart.

This is where the CENO Browser and Ouinet come into play.  This chapter will introduce you to them.
