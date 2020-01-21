FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install -y wget openjdk-8-jre libwebkitgtk-1.0-0 libswt*

RUN useradd --create-home --home-dir /home/tax tax
WORKDIR /home/tax
USER tax

RUN wget https://vaudtax-dl.vd.ch/vaudtax2019/telechargement/linux/64bit/VaudTax_2019.tar.gz
RUN tar zxpf VaudTax_2019.tar.gz
