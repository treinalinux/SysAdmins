#!/bin/bash

# Criado por Alan da Silva Alves
# criar_bridge version 1.0
# Programa criado para o ubuntu 20.04
# 
# Você receber os valores da sua rede:
# 
read -p " Informe um nome para nova bridge: " BR_NAME
read -p " Informe o nome da interface: " BR_INT
read -p " Informe o IP/MASK reservado: " SUBNET_IP
read -p " Informe o IP do router: " GW
read -p " Informe o IP do DNS 1: " DNS1
read -p " Informe o IP do DNS 2: " DNS2
read -p " Informe o Sufixo DNS:  " DNS_SEARCH

# Criando a bridge:
sudo nmcli connection add type bridge autoconnect yes con-name ${BR_NAME} ifname ${BR_NAME}

# Configurando o ip addresses:
sudo nmcli connection modify ${BR_NAME} ipv4.addresses ${SUBNET_IP} ipv4.method manual

# Gateway:
sudo nmcli connection modify ${BR_NAME} ipv4.gateway ${GW}

# DNS
sudo nmcli connection modify ${BR_NAME} ipv4.dns ${DNS1} +ipv4.dns ${DNS2} ipv4.dns-search ${DNS_SEARCH}

# Removendo a interface:
sudo nmcli connection delete ${BR_INT}

# Configurando de fato a bridge:
sudo nmcli connection add type bridge-slave autoconnect yes con-name ${BR_INT} ifname ${BR_INT} master ${BR_NAME}

# Ligando a nova conexão: 
sudo nmcli connection up br10
nmcli connection show
