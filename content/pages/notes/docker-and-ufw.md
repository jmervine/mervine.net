Title: Docker and UFW
Categories: notes, docker, security, localhost, linux
Date: 11 February 2016 14:10
Flags: draft

# Docker and UFW

Having recently gone back to a Linux laptop to make work with Docker a little smoother. I ran in to an issue where my containers couldn't connect to the outside world. Turned out, there were issue with my firewall (UFW). Here's what I did to fix it...

```bash
sudo echo 'DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 --iptables=false"' >> /etc/default/docker
sudo /etc/init.d/docker restart
```

Enjoy!
