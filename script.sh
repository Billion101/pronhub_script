#!/bin/bash

# Install BIND9
# sudo apt update
# sudo apt install -y bind9 bind9utils bind9-doc

# Set hostname
sudo hostnamectl set-hostname ns.ucan.la

# Update /etc/hosts
sudo bash -c "cat > /etc/hosts" <<EOF
127.0.0.1       localhost
192.168.32.139  ns.ucan.la ns
EOF

# Configure /etc/bind/named.conf.options
sudo bash -c "cat > /etc/bind/named.conf.options" <<EOF
options {
    directory "/var/cache/bind";

    recursion yes;
    allow-query { any; };
    listen-on { 127.0.0.1; 192.168.32.139; };
    allow-recursion { 192.168.32.0/24; };

    forwarders {
        8.8.8.8;
        1.1.1.1;
    };

    dnssec-validation auto;
};
EOF

# Configure /etc/bind/named.conf.local
sudo bash -c "cat > /etc/bind/named.conf.local" <<EOF
zone "ucan.la" {
    type master;
    file "/etc/bind/db.ucan.la";
};

zone "32.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.32";
};
EOF

# Create Forward Zone /etc/bind/db.ucan.la
sudo bash -c "cat > /etc/bind/db.ucan.la" <<EOF
\$TTL    604800
@       IN      SOA     ns.ucan.la. admin.ucan.la. (
                         2025051601 ; Serial
                         604800     ; Refresh
                         86400      ; Retry
                         2419200    ; Expire
                         604800 )   ; Negative Cache TTL
;
@       IN      NS      ns.ucan.la.
@       IN      MX 10   mail.ucan.la.

@       IN      A       192.168.32.139
ns      IN      A       192.168.32.139
www     IN      A       192.168.32.200
api     IN      A       192.168.32.201
fin     IN      A       192.168.32.51
mail    IN      A       192.168.32.14
EOF

# Create Reverse Zone /etc/bind/db.192.168.32
sudo bash -c "cat > /etc/bind/db.192.168.32" <<EOF
\$TTL    604800
@       IN      SOA     ns.ucan.la. admin.ucan.la. (
                         2025051601 ; Serial
                         604800     ; Refresh
                         86400      ; Retry
                         2419200    ; Expire
                         604800 )   ; Negative Cache TTL
;
@       IN      NS      ns.ucan.la.

139     IN      PTR     ns.ucan.la.
200     IN      PTR     www.ucan.la.
201     IN      PTR     api.ucan.la.
51      IN      PTR     fin.ucan.la.
14      IN      PTR     mail.ucan.la.
EOF

# Check config syntax
sudo named-checkconf
sudo named-checkzone ucan.la /etc/bind/db.ucan.la
sudo named-checkzone 32.168.192.in-addr.arpa /etc/bind/db.192.168.32

# Restart BIND9
sudo systemctl restart bind9

echo "✅ DNS Server for ucan.la configured successfully on 192.168.32.139!"
