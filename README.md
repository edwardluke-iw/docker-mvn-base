# docker-mvn-base
A docker multi-stage build to create base images for Apache Maven based from the JVM base images that can be used later multistage builds

## Building
This project is capable of generating a number of Docker images that contain Apache Maven installed on top of different versions of the JDK.

The images produced by https://github.com/edwardluke-iw/docker-jvm-base are used as the stages within this multi-stage build.

These can be executed with the Makefile or by runinng the docker commands manually.

### Docker Commands
The Makefile targets are simply wrappers for running the appropriate docker `build` command. For example the difference between the JDK8 and JDK11 builds are shown below:

The only difference between the two commands below is the `--target` parameter and the final image name.

	docker build --file Dockerfile --target mvn-openjdk8 --tag edwardlukeiw/mvn:openjdk8 .

	docker build --file Dockerfile --target mvn-openjdk11 --tag edwardlukeiw/mvn:openjdk11 .

Note the `--target` parameter which specifies which `stage` within the Dockerfile should be used to produce the final image.

### Makefile

To build images for with Apache Maven on JDK8, JDK11 and GraalVM11

    make build_all

To build just the OpenJDK8 image:

    make build_openjdk8

To build just the OpenJDK11 image:

    make build_openjdk11

To build just the GraalJDK11 image:

    make build_graaljdk11-jre

## Dockerfile

The Dockerfile contains a number of named stages using the `AS` command which allows images to be built from layers created within previous build stages. There are three main stages defined within the file:

### `mvn`
This stage is based from the `alpine:latest` image. The stage is called `jvm` which is used as the base layer within the subsequent stages.

### `mvn-openjdk8`
The `mvn-openjdk8` stage extends from the `edwardlukeiw/jvm:openjdk8` image. The maven installation is then copied from the `mvn` base stage using the `COPY --from=mvn` command, This image can be used as the builder for projects which need to compile Java using Maven.

### `mvn-openjdk11`
The `mvn-openjdk11` stage extends from the `edwardlukeiw/jvm:openjdk11` image. The maven installation is then copied from the `mvn` base stage using the `COPY --from=mvn` command, This image can be used as the builder for projects which need to compile Java using Maven.

### `mvn-graaljdk11`
The `mvn-graaljdk11` stage extends from the `edwardlukeiw/jvm:graaljdk11` image. The maven installation is then copied from the `mvn` base stage using the `COPY --from=mvn` command, This image can be used as the builder for projects which need to compile Java using Maven.
