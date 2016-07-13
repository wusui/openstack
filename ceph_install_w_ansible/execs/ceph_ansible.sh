#! /bin/bash
cephnodes=$*
monnode=$1
sudo yum -y install ceph-ansible
cd
sudo ./edit_ansible_hosts.sh $cephnodes
mkdir ceph-ansible-keys
cd /usr/share/ceph-ansible/group_vars/
sudo cp all.sample all
sudo sed -i 's/#fetch_directory:.*/fetch_directory: ~\/ceph-ansible-keys/' all
sudo sed -i 's/#ceph_stable:.*/ceph_stable: true/' all
sudo sed -i 's/#ceph_stable_rh_storage:.*/ceph_stable_rh_storage: true/' all
sudo sed -i 's/#ceph_stable_rh_storage_cdn_install:.*/ceph_stable_rh_storage_cdn_install: true/' all
sudo sed -i 's/#cephx:.*/cephx: true/' all
sudo sed -i 's/#monitor_interface:.*/monitor_interface: eno1/' all
sudo sed -i 's/#journal_size:.*/journal_size: 1024/' all
sudo sed -i 's/#public_network:.*/public_network: 10.8.128.0\/21/' all
sudo cp osds.sample osds
sudo sed -i 's/#fetch_directory:.*/fetch_directory: ~\/ceph-ansible-keys/' osds
sudo sed -i 's/#crush_location:/crush_location:/' osds
sudo sed -i 's/#osd_crush_location:/osd_crush_location:/' osds
sudo sed -i 's/#cephx:/cephx:/' osds
sudo sed -i 's/#devices:/devices:/' osds
sudo sed -i 's/#journal_collocation:.*/journal_collocation: true/' osds
cd
sudo ./edit_groupvars_osds.sh
cd /usr/share/ceph-ansible
sudo cp site.yml.sample site.yml
ansible-playbook site.yml
ssh $monnode sudo ceph osd pool set rbd pg_num 128
sleep 15
ssh $monnode sudo ceph osd pool set rbd pgp_num 128
sleep 30
ssh $monnode sudo ceph health
