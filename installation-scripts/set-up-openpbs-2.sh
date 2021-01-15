# OpenPBS Post Install Configuration - Executed as root

# Argument necessary - username of job submitter account
if [ $# -eq 0 ]; then
	echo "Error: Username not provided"
	exit -1
fi

. /etc/profile.d/pbs.sh
qmgr -c "create node `hostname`"
qmgr -c "set server scheduling=true"
qmgr -c "create queue batch queue_type=execution"
qmgr -c "set queue batch started=true"
qmgr -c "set queue batch enabled=true"
qmgr -c "set queue batch resources_default.nodes=1"
qmgr -c "set queue batch resources_default.walltime=3600"
qmgr -c "set server default_queue=batch"
qmgr -c "set server flatuid = true"
qmgr -c "set server acl_roots += $1@*"
qmgr -c "set server operators += $1@*"
