# Rasp Kube

![Kubernetes](https://img.shields.io/badge/-Kubernetes-3371e3?style=for-the-badge&logo=kubernetes&logoColor=white)
![Raspberry](https://img.shields.io/badge/-RaspberryPi-C51A4A?style=for-the-badge&logo=Raspberry-Pi)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=Ubuntu&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-000000?style=for-the-badge&logo=ansible&logoColor=white)



This repository contains Ansible playbooks to set up a Kubernetes cluster on Raspberry PI 5 using Ubuntu 24.04.

### Prerequisits


- Configure SSH and Static IP:
  - Ensure that SSH is enabled on all Raspberry Pi devices.
  - Assign static IP addresses to each Raspberry Pi.
- Install Ansible:
  - Install Ansible on your control machine (the machine from which you will run the playbooks).

> [!Note]
> Create ssh
> `ssh-keygen -t rsa -b 4096 -C "tribix@machine.local"`
> Copy ssh
> `ssh-copy-id tribix@machine.local`

#### Configure Static IP

```
sudo vim /etc/netplan/50-cloud-init.yaml
```

Below we have an example configuration:

```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.2.10/24
      routes:
        - to: default
          via: 192.168.2.1
      nameservers:
        addresses: [1.1.1.1,8.8.8.8]
```

Save the configuration and apply:

```bash
sudo netplan apply
```

#### Test connection in servers

```
ansible all -m ping
```

_Result_

```bash
node1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}

master1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}
```

#### Repository Structure

```
rasp-kube/
├── ansible.cfg
├── inventory/
│   └── hosts.yaml
├── common/
│   └── all.yaml
├── masters/
│   └── main.yaml
├── nodes/
│   └── main.yaml
└── k8s.yaml
           
```

- **ansible.cfg**: Ansible configuration file.
- **inventory/hosts**.yaml: Inventory file defining the hosts in the cluster.
- **common/all.yaml**: Playbook with common tasks for all hosts.
- **masters/main.yaml**: Playbook to configure the master nodes.
- **nodes/main.yaml**: Playbook to configure the worker nodes.
- **k8s.yaml**: Main playbook that imports the other playbooks.


#### Running the project

```
ansible-playbook k8s.yaml
```

#### Enable Promisc mode (Raspberry in network Wifi)

When use MetalLB you need enable promisc mode in network of the raspberry, because you can problems in comunication.

> [!Important]
> [ISSUE](https://metallb.io/troubleshooting/#using-wifi-and-cant-reach-the-service)
> I try add the configuration in ansible, but I have problem in start service network of the kubernetes.

Copy the [Script](scripts/promisc-service.sh) and send in your cluster.

```bash
chmod +x promisc-service.sh
./promisc-service.sh
```
