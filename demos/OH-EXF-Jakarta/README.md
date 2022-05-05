# Open Horizon EdgeX Foundry Jakarta

## Environment
The following environment variables **must** be set in order to run the make scripts.
```shell
# Sets the scope so that multiple users can use the same instance
EDGE_OWNER=<sg.edge>
# Lets you manage and deploy different group of code across dev, demo, test, prod or project
EDGE_DEPLOY=<dev>
HZN_ORG_ID=<org_id>
HZN_EXCHANGE_USER_AUTH=iamapikey:<your-iamapikey>
# Root bind directory for app volumes
APP_BIND_HORIZON_DIR=/var/local/horizon
```

## Publish
### localhost
Right now, because both the `device-onvif-camera` and `deploy-data` images are not in a docker registry,
the make scripts will automatically push them to a registry running on `localhost:5000`.

Use the following commands to run a local docker registry:
```shell
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

### External Docker Registry
```shell
# build and push device onvif camera to external docker registry
make -C src/device-onvif-camera LOCAL_DOCKER_REGISTRY=<your-docker-registry-base>

# build and push deploy data to external docker registry
make -C src/deploy-data LOCAL_DOCKER_REGISTRY=<your-docker-registry-base>
```

### Networking limitations and issues
#### Consul
By default, `consul` wants to bind to a local IP address as the `Cluster Address`. This is used
to communicate with other `consul` nodes on the network. `Consul` will fail with an error if there
is more than 1 private IPv4 address.

To get around this we tried binding to a network interface, such as `eth0`, however this does not
work because what happens when it is deployed is the `eth0` network is created as a sandbox network for
the service until other services that depend on it come alive. Once they do, they will start attaching their
networks to `consul`, and the management agent will remove the `eth0` interface, causing issues.

How we are getting around this is to use localhost `127.0.0.1` as the `-bind` address / `Cluster Address` address 
(keep in mind this is different from the `-client` address). Essentially this keeps `consul` happy, but more investigation
is needed to see if there is a way to disable that feature altogether, or if using `127.0.0.1` is causing
some unforeseen consequence.

### Implementation Notes
- We aren't making all services depend on `deploy-data`, just the lowest level ones (`consul`, `redis`, `mqtt-broker`).
The reason for this is that we do not need any network connections to it (we just want it started first).

> **Note:** This next bullet no longer appears to be true. For some reason, it seems like the system
> is more stable when **not** using the `wait.sh` script...
> - We are using a custom `wait.sh` script because we have to wait for the networks to stabilize before we
> start the edgex services. If we do not do that, there are some services that will become unstable and unpredictable based on
> the asynchronous nature of the management agent.

#### Json Pre-processing
You may have noticed that some `.json` files have comments in them, in the form of `// comment...`.
Normally, json files do not allow comments in them, so what the `make` commands do is pre-process
the json file to get rid of any lines starting with 0 or more whitespace followed by `//`.

#### Deploy Container
This container is used to deploy a set of scripts and configuration files that are constant, but not
built into the docker images. It is also responsible for creating the `APP_BIND_HORIZON_DIR`, and making it 
read-writeable by the other containers.

Each file that does not start with a `shebang` (`#!`) is passed to `envsubst` on the target deployed
system. What this means is that you can create a file that is configurable based on the deployment.

However, keep in mind that the `envsubst` is happening based on the environment of the `deploy-data`
container, and not necessarily the container that is going to be consuming the files.
