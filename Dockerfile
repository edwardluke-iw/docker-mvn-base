FROM alpine:latest as mvn
ARG MAVEN_VERSION=3.3.9

# install maven
RUN apk add --no-cache curl tar bash && \
    mkdir -p /usr/share/maven && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 && \
    touch stage_015.mvn

FROM edwardlukeiw/jvm:openjdk8 as mvn-openjdk8
RUN touch stage_020.mvn-openjdk8
COPY --from=mvn stage_015.mvn stage_015.mvn
COPY --from=mvn /usr/share/maven /usr/share/maven
ENTRYPOINT [ "/usr/share/maven/bin/mvn" ]

FROM edwardlukeiw/jvm:openjdk11 as mvn-openjdk11
RUN touch stage_020.mvn-openjdk11
COPY --from=mvn stage_015.mvn stage_015.mvn
COPY --from=mvn /usr/share/maven /usr/share/maven
ENTRYPOINT [ "/usr/share/maven/bin/mvn" ]

FROM edwardlukeiw/jvm:openjdk11 as mvn-graaljdk11
RUN touch stage_020.mvn-graaljdk11
COPY --from=mvn stage_015.mvn stage_015.mvn
COPY --from=mvn /usr/share/maven /usr/share/maven
ENTRYPOINT [ "/usr/share/maven/bin/mvn" ]
