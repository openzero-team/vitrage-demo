#!/usr/bin/env bash

apt-get update
apt-get dist-upgrade -y
apt-get install -y git
mkdir -p /devstack
cd /devstack

# Clone if we have to, else just pull.
if [ ! -d .git ]
then
    git clone https://git.openstack.org/openstack-dev/devstack /devstack
else
    git pull
fi

# Make sure the user exists
/devstack/tools/create-stack-user.sh
chown -R stack:stack /devstack

# Create some default passwords
cat >/devstack/.localrc.password <<EOL
DATABASE_PASSWORD=password
RABBIT_PASSWORD=password
SERVICE_PASSWORD=password
ADMIN_PASSWORD=password
EOL

# Add some other settings.
cat >/devstack/local.conf <<EOL
[[local|localrc]]
HOST_IP=192.168.99.99
SERVICE_HOST=$HOST_IP

#CINDER_BRANCH=milestone-proposed
#GLANCE_BRANCH=milestone-proposed
#HORIZON_BRANCH=milestone-proposed
#KEYSTONE_BRANCH=milestone-proposed
#KEYSTONECLIENT_BRANCH=milestone-proposed
#NOVA_BRANCH=milestone-proposed
#NOVACLIENT_BRANCH=milestone-proposed
#NEUTRON_BRANCH=milestone-proposed
#SWIFT_BRANCH=milestone-proposed

enable_plugin vitrage https://github.com/openstack/vitrage
enable_plugin vitrage-dashboard https://github.com/openstack/vitrage-dashboard
enable_plugin ceilometer https://github.com/openstack/ceilometer
enable_plugin aodh https://github.com/openstack/aodh

# add notification from nova, neutron and cinder to vitrage

[[post-config|$NOVA_CONF]]
[DEFAULT]
notification_topics = notifications,vitrage_notifications
notification_driver=messagingv2

[[post-config|$NEUTRON_CONF]]
[DEFAULT]
notification_topics = notifications,vitrage_notifications
notification_driver=messagingv2

[[post-config|$CINDER_CONF]]
[DEFAULT]
notification_topics = notifications,vitrage_notifications
notification_driver=messagingv2

EOL

# Start devstack.
su - stack /devstack/unstack.sh
su - stack /devstack/stack.sh
