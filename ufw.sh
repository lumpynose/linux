ufw default deny
ufw allow from 192.168.50.0/24

ufw enable
systemctl enable ufw
