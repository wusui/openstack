#/bin/bash -fv
#
# Install Openstack.
#     Usage: openstack <openstack-site> <ceph-monitor>
#
# This script installs Openstack on one node, and connects it to a ceph
# cluster on another set of nodes.  It is intended to run from a third
# node.
#
# Assumes a single node Openstack cluster and a single monitor ceph
# cluster.
#
# The execs directory contains scripts to be run on remote sites.
# The files directory contains files to be copied to remote sites.
#

source ./copy_func.sh
source ./fix_conf_file.sh
openstack_node=${1-magna064}
ceph_node=${2-magna029}
./packstack.sh $openstack_node $ceph_node
./connectceph.sh $openstack_node $ceph_node
./image_create.sh $openstack_node $ceph_node
