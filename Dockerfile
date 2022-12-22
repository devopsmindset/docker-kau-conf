FROM ubuntu:20.04
#install basic necessary packages
RUN apt update \
    && apt-get install -y sudo \
    && apt-get install -y wget \
    && apt-get install -y unzip \
    && apt-get install dos2unix
#copy the project into the docker image
WORKDIR /app
COPY . .
#move the script to a different folder to avoid collisions with terraform, and run it
RUN sudo mkdir /opt/script \
    && sudo cp system-configuration.sh /opt/script/system-configuration.sh \
    && sudo dos2unix /opt/script/system-configuration.sh \
    && cd /opt/script \
    && sudo ./system-configuration.sh