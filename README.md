# Docker for offline pcap processing with suricata

### Installation

You need to have docker for this work.. DOH!

```sh
$ ./build.sh
```
### To use

- Create or obtain the PCAP to be analyzed and place it in /data/pcaps
```sh
$ docker --rm -it suricata:latest -r /data/pcaps/<yourpcap>.pcap
```
