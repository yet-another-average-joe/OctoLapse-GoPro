#!/bin/sh

"""
	gopro-take-snapshot.sh

	In OctoLapse, create a profile for a new camera

	Create this script file in "/home/pi/scripts" :
	In a SSH console, type :
	
	cd /home/pi/scripts
	nano gopro-take-snapshot.sh
	paste the contents of this file
	save : Ctrl+O
	then quit : Ctrl+X
	make the script executable :
	sudo chmod +x gopro-take-snapshot.sh

	In camera options, at Snapshot Acquire Script, write :
	/home/pi/scripts/gopro-take-snapshot.sh
"""

# Put the arguments sent by Octolapse into variables for easy use
SNAPSHOT_NUMBER=$1
DELAY_SECONDS=$2
DATA_DIRECTORY=$3
SNAPSHOT_DIRECTORY=$4
SNAPSHOT_FILENAME=$5
SNAPSHOT_FULL_PATH=$6

# Check to see if the snapshot directory exists
if [ ! -d "${SNAPSHOT_DIRECTORY}" ];
then
  echo "Creating directory: ${SNAPSHOT_DIRECTORY}"
  mkdir -p "${SNAPSHOT_DIRECTORY}"
fi

# IMPORTANT - You must add gphoto2 to your /etc/sudoers file in order to execute gphoto2 without sudo
# otherwise the following line will fail.

#sudo gphoto2 --capture-image-and-download --filename "${SNAPSHOT_FULL_PATH}"

#############################################################
#############################################################

"""
	We just replace the call to gphoto2 with a call
	to a Python script that will shoot photos with the GoPro.

	It takes one argument : §6, the full path name to the
	temporary file that OctoLapse will use to build timelapse

"""

python3.6 /home/pi/scripts/gopro-take-snapshot.py $6

#############################################################
#############################################################


if [ ! -f "${SNAPSHOT_FULL_PATH}" ];
then
  echo "The snapshot was not found in the expected directory: '${SNAPSHOT_FULL_PATH}'." >&2 
  exit 1
fi
