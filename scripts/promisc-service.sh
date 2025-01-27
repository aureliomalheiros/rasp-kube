#!/bin/bash

SERVICE_FILE="/etc/systemd/system/promiscuous-mode.service"

sudo bash -c "cat <<EOF > $SERVICE_FILE
[Unit]
Description=Enable promiscuous mode on wlan0
After=network.target

[Service]
Type=oneshot
ExecStart=/sbin/ip link set wlan0 promisc on
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

EOF"

sudo systemctl daemon-reload
sudo systemctl enable promiscuous-mode.service
sudo systemctl start promiscuous-mode.service
sudo systemctl status promiscuous-mode.service
