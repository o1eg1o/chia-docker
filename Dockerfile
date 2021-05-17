FROM ubuntu:latest

EXPOSE 8555
EXPOSE 8444
EXPOSE 8445
EXPOSE 8446
EXPOSE 8447
EXPOSE 8448

ENV keys="/.chia/config/mnemonic_file1.txt"
ENV harvester="true"
ENV farmer="false"
ENV plots_dir="/plots"
ENV farmer_address="192.168.2.2"
ENV farmer_port="8448"
ENV testnet="false"
ENV full_node_port="null"
ARG BRANCH

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y curl jq python3 ansible tar bash ca-certificates git openssl unzip wget python3-pip sudo acl build-essential python3-dev python3.8-venv python3.8-distutils apt nfs-common python-is-python3 vim

RUN echo "cloning main"
RUN git clone --branch main https://github.com/Chia-Network/chia-blockchain.git \
&& cd chia-blockchain \
&& git submodule update --init mozilla-ca \
&& chmod +x install.sh \
&& /usr/bin/sh ./install.sh

WORKDIR /chia-blockchain
RUN mkdir /plots
ADD ./entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "./entrypoint.sh"]
