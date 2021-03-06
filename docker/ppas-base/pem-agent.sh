#!/bin/bash
set -e

PEM_AGENT=/usr/pem-5.0

chown -R enterprisedb:enterprisedb $PEM_AGENT

mkdir ~enterprisedb/.pem && chown enterprisedb:enterprisedb ~enterprisedb/.pem

# grant permission for enterprisedb to start pem agent as root
directive="#includedir /etc/sudoers.d"
[ -f /etc/sudoers ] && if ! grep --quiet "$directive" /etc/sudoers; then
  echo "$directive" >>/etc/sudoers
fi
[ -d /etc/sudoers.d ] || mkdir /etc/sudoers.d
cat > /etc/sudoers.d/01enterprisedb <<-EOF
Cmnd_Alias PEM_AGENT = $PEM_AGENT/bin/pemagent, $PEM_AGENT/bin/pkgLauncher
enterprisedb  ALL=(ALL)   NOPASSWD:   PEM_AGENT
EOF
