# Rasp Kube

You need configure ssh and static IP in your Raspberry.

```
kubernetes-setup/
├── ansible.cfg
├── inventory/
│   ├── hosts.yml
├── group_vars/
│   ├── all.yml
│   ├── masters.yml
│   └── nodes.yml
├── roles/
│   ├── common/
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   ├── handlers/
│   │   │   └── main.yml
│   │   ├── files/
│   │   ├── templates/
│   │   └── vars/
│   │       └── main.yml
│   ├── master/
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   └── templates/
│   ├── node/
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   └── templates/
└── site.yml
           
```
