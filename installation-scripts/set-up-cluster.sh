# Preliminary Setup
echo -n "Enter number of nodes in the cluster:"
read n

echo -n "Enter the common username:"
read username

for i in `seq 1 $n`; do

	echo -n "Enter hostname of the new node:"
	read remote_hostname

	ssh-copy-id $username@$remote_hostname

	# Install required packages
	echo "Installing required packages"
	ssh root@$remote_hostname "apt install -y autoconf automake \
		build-essential expat git libedit-dev libexpat-dev libfabric-dev \
		libpsm2-dev libpsm-infinipath1-dev libibverbs-dev librdmacm-dev \
		libhwloc-dev libical-dev libssl-dev libtool libx11-dev libxext-dev \
		libxft-dev libxt-dev make ncurses-dev perl postgresql postgresql-contrib \
		postgresql-server-dev-all python3-dev sendmail-bin sudo swig \
		tcl-dev tk-dev tmux vim-nox"

	# Add user to sudo group
	echo "Adding $username to sudo group"
	ssh root@$remote_hostname "/usr/sbin/usermod -aG sudo $username"

	# Enable passwordless sudo
	echo "Adding passwordless sudo"
	ssh root@$remote_hostname "echo $username ALL = \(ALL\) NOPASSWD: ALL >>/etc/sudoers"

	# Set up the node running as normal user
	ssh $username@$remote_hostname 'bash -s' <set-up-node.sh

	# Run postinstall configuration
	ssh root@$remote_hostname 'bash -s csrp' <set-up-openpbs-2.sh

done
