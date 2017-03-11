#
# Super simple example of a Dockerfile
#
FROM ubuntu:latest
MAINTAINER Ranjit Kumar "ranjitkumar.518@gmail.com"

RUN apt-get update
RUN apt-get install -y tomcat
RUN apt-get install nano

ADD hiiii.txt

WORKDIR /home
