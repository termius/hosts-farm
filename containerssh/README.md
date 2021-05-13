# ContainerSSH quick start

> A copy from [the ContainerSSH quick start](https://raw.githubusercontent.com/ContainerSSH/examples/main/quick-start/README.md)

This is a quick start guide to get a test server up and running in less than 5 minutes with [docker-compose](https://docs.docker.com/compose/).

<center><strong>⚠️⚠️⚠️ This example is not production-ready! Please read the <a href="https://containerssh.io">ContainerSSH documentation</a>. ⚠️⚠️⚠️</strong></center><br /><br />

**⚠️ Warning:** This setup will let any password authenticate. Only use it for testing.

## Step 1: Set up a Dockerized or Kubernetes environment

To run this quick start please make sure you have a working [Docker environment](https://docs.docker.com/get-docker/) and a working [docker-compose](https://docs.docker.com/compose/).

Alternatively, you can also set up a Kubernetes cluster. We recommend setting up [Docker Desktop](https://www.docker.com/products/docker-desktop), [k3s](https://k3s.io/), or [Kubernetes in Docker](https://kind.sigs.k8s.io/).

## Step 2: Download the sample files

Please download the contents of the [example directory](https://github.com/ContainerSSH/examples/tree/main/quick-start) from the source code repository.

## Step 3: Launch ContainerSSH

For a Docker environment run `docker-compose up -d` in the downloaded `quick-start` (this) directory.

For a Kubernetes environment run `kubectl apply -f kubernetes.yaml` in the `quick-start` (this) directory.

## Step 4: Logging in

Run `ssh foo@localhost -p 2222` on the same machine via a new terminal window. This is your test client. You should be able to log in with any password.

Alternatively you can also try the user `busybox` to land in a Busybox container.

## Step 5: Cleaning up

Once you're done, you can shut down the server using the `docker-compose down`, then remove the images using `docker-compose rm` and remove the guest image by running `docker image rm containerssh/containerssh-guest-imag` for a Docker environment, or `kubectl delete -f kubernetes.yaml` for the Kubernetes environment.

## Step 6: Making it productive

The authentication and configuration server included in the example is a dummy server and lets any password in. To actually use ContainerSSH, you will have to write [your own authentication server](https://containerssh.io/getting-started/authserver/). We recommend reading the [architecture overview](https://containerssh.io/getting-started/architecture/) before proceeding.

**👉 Tip:** You can pass the `CONTAINERSSH_ALLOW_ALL` environment variable to the demo auth-config server to build a honeypot.