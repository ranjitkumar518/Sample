#
# Super simple example of a Dockerfile
#
FROM ubuntu:latest
MAINTAINER Ranjit Kumar "ranjitkumar.518@gmail.com"

CMD apt-get update
CMD apt-get install -y tomcat
CMD apt-get install -y nano

# ADD hiiii.txt

# WORKDIR /home
ENTRYPOINT ["bin/bash"]
RUN exit
