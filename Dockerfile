FROM registry.access.redhat.com/ubi8:8.8-1067.1696517599 as jre

RUN mkdir -p /opt/java \
 && curl -fsSLo - https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21%2B35/OpenJDK21U-jdk_x64_linux_hotspot_21_35.tar.gz \
    | tar -xz -C /opt/java --strip-components=1 \
 && mkdir -p /build

ENV PATH=${PATH}:/opt/java/bin

ARG MODULES

RUN jlink --add-modules ${MODULES} --output /build/jre

FROM registry.access.redhat.com/ubi8-micro:8.8-7.1696517612 as target

RUN mkdir /app
COPY --from=jre /build/jre /opt/java
ENV PATH=${PATH}:/opt/java/bin

COPY api.jar /app/api.jar

CMD java -jar /app/api.jar
