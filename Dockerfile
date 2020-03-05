FROM alpine:latest as mvn
# Set up shared environment variables
ARG MAVEN_VERSION=3.3.9

# Install maven using Alpine package manager
RUN apk add --no-cache curl tar bash && \
    mkdir -p /usr/share/maven && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1

# Add a marker file for debugging purposes
RUN touch stage_015.mvn

FROM edwardlukeiw/jvm:openjdk8 as mvn-openjdk8
# Add a marker file for debugging purposes
RUN touch stage_020.mvn-openjdk8
# Copy marker file from the previous stage
COPY --from=mvn stage_015.mvn stage_015.mvn
# Copy the maven install from the previous stage
COPY --from=mvn /usr/share/maven /usr/share/maven
# Create a symlink to the maven executable
RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

FROM edwardlukeiw/jvm:openjdk11 as mvn-openjdk11
# Add a marker file for debugging purposes
RUN touch stage_020.mvn-openjdk11
# Copy marker file from the previous stage
COPY --from=mvn stage_015.mvn stage_015.mvn
# Copy the maven install from the previous stage
COPY --from=mvn /usr/share/maven /usr/share/maven
# Create a symlink to the maven executable
RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

FROM edwardlukeiw/jvm:graaljdk11 as mvn-graaljdk11
# Add a marker file for debugging purposes
RUN touch stage_020.mvn-graaljdk11
# Copy marker file from the previous stage
COPY --from=mvn stage_015.mvn stage_015.mvn
# Copy the maven install from the previous stage
COPY --from=mvn /usr/share/maven /usr/share/maven
# Create a symlink to the maven executable
RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
