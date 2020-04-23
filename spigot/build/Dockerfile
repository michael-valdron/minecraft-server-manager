FROM openjdk:9-jdk-slim

ENV SPIGOT_URL=https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN apt update && apt install curl git -y

RUN mkdir /spigot && mkdir /data

RUN curl -o /spigot/BuildTool.jar $SPIGOT_URL

COPY ./build.sh /build.sh

RUN chmod 755 /build.sh

WORKDIR /data

CMD ["/build.sh"]