<div align="center">

## Game Containers

  _An opinionated collection of containers for running game servers_

</div>

### Mission Statement

The goal of this project is to create a suite of base containers for streamlined and [rootless](https://rootlesscontaine.rs/) game servers.

These containers will not contain the games themselves, but will serve as the base environment for them to be installed, updated, and maintained at runtime.

### Conventions

#### Versioning

Some aspects with versioning are still TBD. I would prefer [semantically versioned](https://semver.org/) containers and having images tied to regular snapshot releases, like a `2026.2.0`. However, also may need multiple versions of some packages, such as multiple versions of Java, and then either need to build a large Java container with many versions, or multiple slimmer ones.

#### Debian Based

All containers are currently based on Debian 13 (trixie). Debian offers wide compatibility, long life per release, well maintained upstream.

#### Rootless

All images expect to run as the `nobody` (65534:65534) user. If a process needs to be privileged user, it can be escalated at runtime using your docker-compose or Kubernetes deployment. The containers are flexible to run as any user, they don't need to run as `nobody`. If there are sidecar containers that expect to run as `1000`, for instance, you can use that for all the containers here as well, as long as the game volume is mounted with correct permissions.

#### Game Volume

Images will use a `/game` volume which is expected to store any persisted data. Games should be installed at runtime into this directory. Some containers may persist additional data there, but should be careful with directory naming to avoid collisions, and in many cases should go under dot directories, like `/game/.local`.
