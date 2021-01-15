#/bin/bash

echo "Setting up node $HOSTNAME"

# Change default editor to vim
sudo update-alternatives --set editor /usr/bin/vim.nox

# Create a src directory for all source files
sudo mkdir /src
sudo chown $USER:$USER /src
cd /src

# MPICH Installation
wget http://www.mpich.org/static/downloads/3.4/mpich-3.4.tar.gz
tar -xf mpich-3.4.tar.gz
cd mpich-3.4
./configure --prefix=/usr/local/ --disable-fortran |& tee c.txt
make |& tee m.txt
sudo make install |& tee mi.txt
cd ../

# OpenPBS Installation
OPENPBS_PREFIX=/opt/pbs

wget https://github.com/openpbs/openpbs/archive/v20.0.1.tar.gz -O openpbs-20.0.1.tar.gz
tar -xf openpbs-20.0.1.tar.gz
cd openpbs-20.0.1
./autogen.sh
./configure --prefix=$OPENPBS_PREFIX |& tee c.txt
make |& tee m.txt
sudo make install |& tee mi.txt
sudo $OPENPBS_PREFIX/libexec/pbs_postinstall
sudo chmod 4755 $OPENPBS_PREFIX/sbin/pbs_iff $OPENPBS_PREFIX/sbin/pbs_rcp
cd ../

# OpenPBS post install configuration
# Add hostname to nonloopback IP resolution
sudo sed -i "3i `ip a | awk 'NR==9{print $2}' | rev | cut -c4- | rev`\t`hostname`.`domainname -d`\t`hostname`" /etc/hosts
sudo systemctl restart pbs.service

# Munge Installation
wget https://github.com/dun/munge/releases/download/munge-0.5.14/munge-0.5.14.tar.xz
tar -xf munge-0.5.14.tar.xz
cd munge-0.5.14
./configure --prefix=/usr/local --sysconf=/etc/munge/ |& tee c.txt
make |& tee m.txt
sudo make install |& tee mi.txt
cd ../

# Slurm Installation
wget https://download.schedmd.com/slurm/slurm-20.11.2.tar.bz2
tar -xf slurm-20.11.2.tar.bz2
cd slurm-20.11.2
./configure --prefix=/usr/local/ --sysconfdir=/etc/slurm/ |& tee c.txt
make |& tee m.txt
sudo make install |& tee mi.txt
cd ../

# Slurm Configuration
sudo mkdir /etc/slurm/
#copy from net

# Update ldconfig library path cache
sudo ldconfig
