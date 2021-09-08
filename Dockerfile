FROM ubuntu:latest

ENV tz=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$tz /etc/localtime && echo $tz > /etc/timezone

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install git

RUN apt-get install npm -y
RUN apt-get install yarn -y
RUN apt-get install nodejs -y

RUN cd ~
COPY . url-tetris/
WORKDIR url-tetris

RUN ls
