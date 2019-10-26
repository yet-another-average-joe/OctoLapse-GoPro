#!/usr/bin/python3.6

"""
	This script has to be called by "gopro-take-snapshot.sh"
	It takes one argument : argv[1] = SNAPSHOT_FULL_PATH, the full path
	to the temporary JPG that will be used by OctoLapse to build the timelapse

	gopro-take-snapshot.py :
	
	- sends the command take_photo() to the GoPro
	- downloads the JPG file
	- deletes the file on the GoPro
	- moves / rename it to argv[1]

	Prerequesites :

	- python 3.6 or above : https://www.python.org/downloads/source/
	- gopro-py-api : https://github.com/KonradIT/gopro-py-api

	Create this script file in "/home/pi/scripts" :

	cd /home/pi/scripts
	nano gopro-take-snapshot.py
	paste the contents of this file
	save : Ctrl+O
	quit : Ctrl+X
"""

# imports
from goprocam import GoProCamera
import sys, shutil, os

# script must be executed in gopro-py-api directory
os.chdir("/home/pi/gopro-py-api")

# create the GoPro object
cam = GoProCamera.GoPro()

"""
	Tested with GoPro 3 only !

	The construtor parameters depend on the model. See :
	
	https://github.com/KonradIT/gopro-py-api/blob/master/docs/docs.md

	If the camera is a GoPro 3, power_on() does not work properly.
	A first call to the constructor turns power on,
	but the object is not created. A 2nd call does it.
	
	https://github.com/KonradIT/gopro-py-api/issues/83
	
"""

#cam = GoProCamera.GoPro()

# take one photo, get its URL
urlFileName=cam.take_photo() # default : delay = 1sec

# download photo to the current directory ("/home/pi/gopropy-api")
cam.downloadLastMedia(urlFileName)

"""
	delete picture on GoPro ; mimics OctoLapse "take-snapshot.sh" script behaviour :
	gphoto2 --capture-image-and-download --filename "${SNAPSHOT_FULL_PATH}"
	to be commented if images have to be kept on the GoPro
"""

cam.delete("last")

"""
	naming conventions :
	image URL on the GoPro : http://10.5.5.9:8080/videos/DCIM/108GOPRO/GOPR0136.JPG
	local (downloaded) file name : 108GOPRO-GOPR0136.JPG
	we have to build this name from the URL
"""

#search for "DCIM" in the URL
iFileNamePos = urlFileName.find("DCIM")

# get "nnnGOPRO/GOPRxxxxJPG"
strSubPath = urlFileName[iFileNamePos+len("DCIM/") : len(urlFileName)]

# replace '/' with '-'
iSlash = strSubPath.find("/")
strPrefix = strSubPath[0 : iSlash]
strName = strSubPath[iSlash+1 : len(urlFileName)]
strLocalFileName = strPrefix + '-' + strName

"""
	rename + move local file to the OctoLapse temp folder
	argv[1] : SNAPSHOT_FULL_PATH
"""
shutil.move(strLocalFileName, sys.argv[1])

"""
		
"""

#cam.power_off()

