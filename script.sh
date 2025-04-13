#!/bin/bash

# Linux Final Skill Exam Auto-Setup Script

# 1. Set static IP address (you can change interface & IP as needed)
echo "Setting static IP..."
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
EOF

systemctl restart networking

# 1.c) Install Samba
echo "Installing samba..."
apt update
apt install -y samba

# 1.d) Check smbd status
systemctl status smbd

# 2. Create groups
echo "Creating groups..."
groupadd IT
groupadd HR
groupadd Accounting

# 2.2 & 2.3) Create Office_Works directory structure
mkdir -p /home/Office_Works/{Public,IT,HR,Accounting,Users}

# Set ownership and permissions
echo "Setting ownerships and permissions..."
chown -R nobody:nogroup /home/Office_Works/Public
chown -R root:IT /home/Office_Works/IT
chown -R root:HR /home/Office_Works/HR
chown -R root:Accounting /home/Office_Works/Accounting
chown -R root:root /home/Office_Works/Users

chmod -R 775 /home/Office_Works/Public
chmod -R 770 /home/Office_Works/{IT,HR,Accounting,Users}

# 2.4) Create users and assign to directories
declare -A users=(
  [keomany]=IT
  [phuvong]=IT
  [xengkeo]=IT
  [vanhmaly]=HR
  [alisa]=HR
  [manychan]=HR
  [nithda]=HR
  [sychan]=HR
  [vongdeun]=Accounting
  [khankeo]=Accounting
)

for user in "${!users[@]}"; do
    group=${users[$user]}
    useradd -m -d /home/Office_Works/Users/$user -g $group $user
    echo "$user:123456" | chpasswd
    smbpasswd -a $user <<EOF
123456
123456
EOF
    chown -R $user:$group /home/Office_Works/Users/$user
    chmod -R 700 /home/Office_Works/Users/$user
done

# 3.1) Configure smb.conf
echo "Backing up and updating smb.conf..."
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

cat <<EOL >> /etc/samba/smb.conf

[Public]
   path = /home/Office_Works/Public
   writable = yes
   guest ok = yes
   guest only = yes
   force create mode = 775
   force directory mode = 775

[IT]
   path = /home/Office_Works/IT
   writable = yes
   guest ok = no
   valid users = @IT
   force create mode = 770
   force directory mode = 770
   inherit permissions = yes

[HR]
   path = /home/Office_Works/HR
   writable = yes
   guest ok = no
   valid users = @HR
   force create mode = 770
   force directory mode = 770
   inherit permissions = yes

[Accounting]
   path = /home/Office_Works/Accounting
   writable = yes
   guest ok = no
   valid users = @Accounting
   force create mode = 770
   force directory mode = 770
   inherit permissions = yes

[Users]
   path = /home/Office_Works/Users
   writable = yes
   guest ok = no
   valid users = @IT @HR @Accounting
   force create mode = 770
   force directory mode = 770
   inherit permissions = yes
EOL

# Restart samba
echo "Restarting Samba service..."
systemctl restart smbd
systemctl enable smbd

echo "✅ Setup complete!"
