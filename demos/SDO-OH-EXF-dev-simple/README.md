# Demonstration of SDO, OH, and EXF

## Introduction

This is a simple demonstration geared towards developers.  It begins with the Open Horizon all-in-one installation (including SDO services) in a single VM.  Running the modified SDO script, it will boot a simulated device and then install and configure an Open Horizon Agent.  The Agent will then contact the Management Hub and receive a proposed agreement to install and run an EdgeX Foundry (EXF) instance.  EXF, in turn, will be configured to run a Random Number Device service.

## Requirements

* An x86_64/amd64-based VM with Ubuntu 18.04 Server, 1 vCPU, 4GB RAM, and 20GB disk

## Instructions

### Step One: Prepare the OS

* Boot the VM and log in.  Become root with `sudo -i`.
* **Optional** - Update the OS and install any pre-requisites
``` shell
apt-get -y update
apt-get -y upgrade
apt-get -y install jq
```

### Step Two: Install Open Horizon

> If Open Horizon is already installed and configured properly, skip step two.

* **Optional** - Determine the VM's local IP address and `export HZN_LISTEN_IP=<local-IP-address-here>` if the network connection is bridged.  If the IP address is accessible outside of the VM, then you will be able to connect to any exposed ports from outside the VM.  Without this step, the services will only be available inside the VM.
* Install the all-in-one Open Horizon instance by following [these instructions](https://github.com/open-horizon/devops/tree/master/mgmt-hub).
* **NOTE** Save the credentials shown at the end of the installation process.  You will need these later.
* Set the following environment variables to connect to the Exchange and to allow publishing.  Replace the `<values>` with the actual value indicated.  Also add them to your shell's RC file if you'd like them to persist beyond this session.
``` shell
export HZN_ORG_ID=myorg
export HZN_EXCHANGE_USER_AUTH=admin:<insert value from installation credentials>
export HZN_DEVICE_TOKEN=<insert value from installation credentials or use random string>
export HZN_DEVICE_ID=node1
export HZN_EXCHANGE_URL=http://<local-IP-address-here>:3090/v1/
export HZN_FSS_CSSURL=http://<local-IP-address-here>:9443/
```

### Step Three: Configure and publish the definition files for the EXF Service

* Clone the EdgeX Foundry integration repository and navigate to the `configs` folder:
``` shell
git clone https://github.com/edgexfoundry-holding/orra.git
cd orra/demos/SDO-OH-EXF-dev-simple
```
* Publish the service and pattern:
``` shell
hzn exchange service publish -P -f configuration/service.json
hzn exchange pattern publish -f configuration/pattern.json
```
* Create the Docker volumes, temporary and configuration folders, copy the EdgeX Foundry service configuration patterns to their expected location:
``` shell
mkdir -p /var/run/edgex/logs
mkdir -p /var/run/edgex/data
mkdir -p /var/run/edgex/consul/data
mkdir -p /var/run/edgex/consul/config
mkdir -p /root/res
chmod -R a+rwx /var/run/edgex
chmod -R a+rwx /root/res
cp res/* /root/res
```
* Publish the updated node policy:
``` shell
hzn unregister -f
hzn register --policy=configuration/node.policy
```
* Publish the deployment policy, which should immediately cause an agreement to be negotiated with your node:
``` shell
hzn exchange deployment addpolicy -f configuration/deployment.policy.json myorg/policy-com.github.joewxboy.horizon.edgex_1.0.1
```
* Watch for an agreement to be formed:
``` shell
watch hzn agreement list
```
* Watch for the containers to be running:
``` shell
watch docker ps
```
* Make a request to the EdgeX endpoint for the Random Number Virtual Device:
``` shell
watch "curl --silent http://localhost:48080/api/v1/event | jq .[0].readings[0].value"
```
