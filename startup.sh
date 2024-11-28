#!/bin/bash

git clone --branch v2.26.0 --depth 1 https://github.com/kubernetes-sigs/kubespray.git

sudo apt install -y python3.11-venv

python3 -m venv rasp-kube

source rasp-kube/bin/activate

pip install ruamel.yaml
pip install -U -r kubespray/requirements.txt


declare -a IPS=("192.168.2.10 192.168.2.20")

mkdir -p inventory/raspberries

CONFIG_FILE=inventory/raspberries/hosts.yaml python3.11 kubespray/contrib/inventory_builder/inventory.py ${IPS[@]}

touch inventory/raspberries/cluster-config.yaml
echo "cluster_name: rasp-kube" >> inventory/raspberries/cluster-config.yaml
echo "kube_version: v1.30.0" >> inventory/raspberries/cluster-config.yaml
