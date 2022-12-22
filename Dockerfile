FROM ubuntu:20.04
#install basic necessary packages
RUN apt update \
    && apt-get install -y sudo \
    && apt-get install -y wget \
    && apt-get install -y unzip \
    && apt-get install dos2unix
#copy the script into the docker image
WORKDIR /app
COPY . .
#run the configuration script
RUN sudo dos2unix ./system-configuration.sh \
    && sudo ./system-configuration.sh