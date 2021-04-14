# Docker

Dockerfiles for building and running the FUNcube source

## Pre-requisites

Linux target, Rasbian 4+ (RPi) or Debian 10+, tested on ARM and x86-64 architectures.

On target (RPi, x86 Debian), you will need the `docker.io` and `git` packages, the following notes may help when installing:

 * Ensure `sudo iptables -L` command works before installing `docker.io`. If you experience an error, you may need to change the alternative:<br/>
   `sudo update-alternatives --set iptables /usr/sbin/iptables-legacy`
 * Now install packages:<br/>
   `sudo apt-get install docker.io git`
 * Add the default user (eg: `pi` or yourself) to the `docker` group:<br/>
   `sudo adduser pi docker`
 * Reboot to ensure everything comes up, check with:<br/>
   `docker ps`<br/>
   which should not show any errors.

## Build steps

```bash
# get the dockerfiles to build the containers
git clone git://github.com/funcube-dev/docker.git
cd docker
# gets the latest code, *note* update will refuse to overwrite code directories (for safety) so 
# to re-run you will need to manualy remove one or more of them (LimeSuite, go, funcubeLib)
./update.sh
# builds the build container and the code.
./build.sh
```

In addition to the `build.sh` script there is a `develop.sh` script that will start a bash shell in a docker container with all the tools GCC/G++/golang etc to work on the code. This container mounts the go and funcubeLib subdirectories from the host OS, so changes made to the code in the container are persisted outside.

run `build.sh` to build all the docker containers.

base-context folder contains tar files of all the source used for the build container, done it this way for now to be sure of a repeatable build. The tar files can be updated (if needed) by running `update.sh` (first remove the cloned folders go, LimeSuite, funcubeLib).

`develop.sh` will create you a shell in the build container with the go and funcubeLib directories mounted from outside the container, this allows you to build everything and preserve the results.

## **Raspberry Pi based FUNcube Telemetry Receiver**

To create the configuration files, type the following at a command prompt
```bash
	sudo mkdir /boot/config

	cd /boot/config

	sudo touch fcdecode.conf
	sudo touch fcwarehouse.conf
```

Using an editor of your choice, edit the fcdecode.conf file and add the following

    # port to send decoded packets (default 64514, that of the encodeserver)
    connectport = 64518
    
    # frequecy in Hz to tune fc dongle to (default 145860000)
    frequency = 145900000
    
    # audio in device id (names do not work) (default -1, means default device)
    audiodevicein = -1
    
    # audio out device id (names do not work) (default -1, means default device)
    audiodeviceout = -1

	# Enable the Bias T function on the FUNcube Dongle (Default 0, means disabled)
	biast = 0

	# Define the number of peak decoders (Default 5)
	numdecoders = 5


Using an editor of your choice, edit the fcwarehouse.conf file and add the following

	# Enter your FUNcube warehouse registration details in the following two parameters
	# To register an account, go to https://http://data.amsat-uk.org/registration

	authcode = "Your AuthCode"
	siteid = "Your SiteID"
	
	# how many times to try sending a frame to the warehouse before abandoning it 
	# and moving onto next frame (default -1 retry forever)
	#retryattempts = -1
	
	# time beween failed upload retry attempts (default 60 seconds)
	#retrywaitseconds = 60
	
	# url to upload packets
	#url = "http://data.amsat-uk.org/"


## Starting the Decode Container

With all of the above steps carried out, create a script file in your home directory with the following contents:-

	CURRENT_DIR=$(dirname $(readlink -f $0))
	echo Using path: $CURRENT_DIR
	
	docker run -ti \
	           --rm \
	           --privileged \
	           -v /boot/config/:/config/ \
	           fcrun:1.0.5

Make sure the FUNcube Dongle (Pro or Pro +) is plugged into the Raspberry Pi.

Execute this script file in a terminal for an interactive docker session.

If you want to run the docker image in the background and have it restart automatically on reboot, run the following command:-
	
	docker run -d \
	           --privileged \
	           -v /boot/config/:/config/ \
	           fcrun:1.0.5
