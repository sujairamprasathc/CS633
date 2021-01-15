# Installation Instructions
1. Install minimal Debian Buster (-desktop-environment, +ssh-server)
2. Enable ssh as root by editing /etc/ssh/sshd\_config
3. Run the script [set-up-cluster](/installation-scripts/set-up-cluster.sh)
from a Debian system that is in the same subnet as the cluster (in my case,
another virtual machine running Debian on the same host which I use as my
daily driver)
4. Disable ssh as root to secure the nodes
