#!/bin/bash

# Static values
IP="192.168.32.130"
DOMAIN="kitthisak.com"
REVERSE="32.168.192"
HOSTNAME="ns.${DOMAIN}"
FORWARD_ZONE_FILE="/etc/bind/db.${DOMAIN}"
REVERSE_ZONE_FILE="/etc/bind/db.192.168.32"

echo "➡️ Setting hostname..."
sudo hostnamectl set-hostname $HOSTNAME

echo "➡️ Updating /etc/hosts..."
sudo bash -c "cat > /etc/hosts" << EOF
127.0.0.1       localhost
127.0.1.1       server

::1             ip6-localhost ip6-loopback
fe00::0         ip6-localnet
ff00::0         ip6-mcastprefix
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters

${IP}  ${HOSTNAME} ns
EOF

echo "➡️ Configuring named.conf.options..."
sudo bash -c "cat > /etc/bind/named.conf.options" << EOF
options {
    directory "/var/cache/bind";

    recursion yes;
    allow-query { any; };
    listen-on { 127.0.0.1; ${IP}; };
    allow-recursion { 192.168.32.0/24; };

    forwarders {
        8.8.8.8;
        1.1.1.1;
    };

    dnssec-validation auto;
};
EOF

echo "➡️ Configuring named.conf.local..."
sudo bash -c "cat > /etc/bind/named.conf.local" << EOF
zone \"${DOMAIN}\" {
    type master;
    file \"${FORWARD_ZONE_FILE}\";
};

zone \"${REVERSE}.in-addr.arpa\" {
    type master;
    file \"${REVERSE_ZONE_FILE}\";
};
EOF

echo "➡️ Creating forward zone file..."
sudo cp /etc/bind/db.local ${FORWARD_ZONE_FILE}
sudo bash -c "cat > ${FORWARD_ZONE_FILE}" << EOF
\$TTL    604800
@       IN      SOA     ${HOSTNAME}. admin.${DOMAIN}. (
                         2         ; Serial
                    604800         ; Refresh
                     86400         ; Retry
                   2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      ${HOSTNAME}.
@       IN      MX 10   mail.${DOMAIN}.

@       IN      A       ${IP}
ns      IN      A       ${IP}
mail    IN      A       192.168.32.131
www     IN      A       192.168.32.132
EOF

echo "➡️ Creating reverse zone file..."
sudo cp /etc/bind/db.127 ${REVERSE_ZONE_FILE}
sudo bash -c "cat > ${REVERSE_ZONE_FILE}" << EOF
\$TTL    604800
@       IN      SOA     ${HOSTNAME}. admin.${DOMAIN}. (
                         2         ; Serial
                    604800         ; Refresh
                     86400         ; Retry
                   2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      ${HOSTNAME}.
@       IN      A       ${IP}
130     IN      PTR     ${HOSTNAME}.
131     IN      PTR     mail.${DOMAIN}.
132     IN      PTR     www.${DOMAIN}.
EOF

echo "➡️ Checking BIND configuration..."
sudo named-checkconf
sudo named-checkzone ${DOMAIN} ${FORWARD_ZONE_FILE}
sudo named-checkzone ${REVERSE}.in-addr.arpa ${REVERSE_ZONE_FILE}

echo "➡️ Restarting BIND9..."
sudo systemctl restart bind9

echo "➡️ Configuring UFW firewall..."
sudo ufw --force enable
sudo ufw allow 53/tcp
sudo ufw allow 53/udp

echo "✅ DNS Server setup for ${DOMAIN} is complete!"
