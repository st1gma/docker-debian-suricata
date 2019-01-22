# Docker for offline pcap processing with suricata

### Installation
You need to have docker for this work.. DOH!
```sh
$ ./build.sh
```

### To use
Create or obtain the PCAP to be analyzed and place it in /data/pcaps
```sh
$ docker --rm -it suricata:latest -r /data/pcaps/<yourpcap>.pcap
```
Create a file named custom.rules in /data/configs and add all your custom rules, they will be automatically ingested.

### Where are mah logs?
The following command should ran on the host ;)
```sh
$ tail -f /data/logs/fast.log
```
