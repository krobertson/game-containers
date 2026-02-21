<div align="center">

## Game Containers

  _An opinionated collection of containers for running game servers_

</div>

### Mission Statement

The goal of this project is to create a suite of base containers for [semantically versioned](https://semver.org/) and [rootless](https://rootlesscontaine.rs/) game servers.

These containers will not contain the games themselves, but will serve as the base environment for them to be installed, updated, and maintained at runtime.

### Conventions

#### Rootless

All images expect to run as the `nobody` (65534:65534) user. If a process needs to be privileged user, it can be escalated at runtime using your docker-compose or Kubernetes deployment.

#### Game Volume

Images will use a `/game` volume which is expected to store any persisted data. Games that are installed at runtime should use a subdirectory, such as `/game/rust`. Other tooling with some of the images will also persisted to the game volume, such as steamcmd and Wine.
