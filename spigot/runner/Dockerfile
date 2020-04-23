FROM openjdk:9-jdk-slim

RUN mkdir /data

COPY ./start.sh /start.sh

RUN chmod 755 /start.sh

WORKDIR /data

CMD ["/start.sh"]