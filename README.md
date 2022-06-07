# asterisk-docker
The project to build an Asterisk Docker image based on Alpine Linux.

Check out the prebuilt image on Docker Hub: https://hub.docker.com/r/iwayvietnam/asterisk

### How to start a new Asterisk container from prebuilt Docker image
##### Create a new Docker volume for Asterisk container:
```bash
$ docker volume create asterisk-sounds
$ docker volume create asterisk-keys
$ docker volume create asterisk-phoneprov
$ docker volume create asterisk-spool
$ docker volume create asterisk-log
```
##### Run Asterisk in a container:
```bash
$ docker run --name asterisk -it \
-p 0.0.0.0:5060:5060 -p 0.0.0.0:5060:5060/udp \
-v asterisk-sounds:/var/lib/asterisk/sounds \
-v asterisk-keys:/var/lib/asterisk/keys \
-v asterisk-phoneprov:/var/lib/asterisk/phoneprov \
-v asterisk-spool:/var/spool/asterisk \
-v asterisk-log:/var/log/asterisk \
iwayvietnam/asterisk
```

### LICENSE
This work is released under GNU General Public License v3 or above.
