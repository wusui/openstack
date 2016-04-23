#/bin/bash -fv
ceph_node=${1-magna029}
source copy_func.sh
copy_file files/$OS_CEPH_ISO $ceph_node .
copy_file execs/ceph_cluster.sh $ceph_node . 0777 
copy_file execs/ceph-pool-create.sh $ceph_node . 0777
ssh $ceph_node ./ceph_cluster.sh $*