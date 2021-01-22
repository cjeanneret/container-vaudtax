FROM docker.io/library/ubuntu:18.04

ARG year=2019

RUN apt update && apt upgrade -y
RUN apt install -y wget openjdk-8-jre libwebkitgtk-1.0-0 libswt*

RUN useradd --create-home --home-dir /home/tax tax
WORKDIR /home/tax
USER tax

RUN wget https://vaudtax-dl.vd.ch/vaudtax${year}/telechargement/linux/64bit/VaudTax_${year}.tar.gz
RUN tar --transform "s#^[^/]*/#./#" -zxpf VaudTax_${year}.tar.gz
