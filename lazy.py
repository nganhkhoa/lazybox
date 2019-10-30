# make sure that in cmd
# ftype Python.File
# returns python3 path
# change HKEY_CLASSES_ROOT\Python.File\shell\open\command to python3 binary

import os
import subprocess

import docker

from os.path import expanduser
from winreg import OpenKey, CloseKey
from pprint import pprint

IS_DEV = True
DEV_IMAGE_TAG = 'luibo/lazybox:v0.2'
IMAGE_TAG = 'luibo/lazybox'
IMAGE_NOT_EXIST = 1
IMAGE_EXIST = 2
HOME = expanduser("~")
DESKTOP = "{}\Desktop".format(HOME)

# lazy data
LAZY = "{}\lazy".format(HOME)
LAZY_HOME = "{}\home".format(LAZY)
LAZY_BIN = "{}\\bin".format(LAZY)

try:
	client = docker.from_env()
except BaseException:
	print('No docker installed')
	print('Cannot connect to docker, has docker run?')
	exit()

images = client.images.list()
img_status = IMAGE_NOT_EXIST
img_tag = ''
for image in images:
	t = DEV_IMAGE_TAG if IS_DEV else IMAGE_TAG
	for tag in image.tags:
		if t not in tag:
			continue
		img_status = IMAGE_EXIST
		img_tag = tag
	if img_status == IMAGE_EXIST:
		break

if img_status == IMAGE_NOT_EXIST:
	print("It seems this is your first time")
	print("We will")
	print("Pull the luibo/lazybox image")
	print("Run a container that maps {} and D:\ to /root/workspace and /root/drive/d".format(HOME))
	print("Fix registry entry at HKEY_CLASSES_ROOT\Python.File\shell\open\command to python3 installation path")
	print("Put this script at {} and add to PATH".format(LAZY_BIN))

	# TODO: Fix registry value
	# TODO: Put script at LAZY_BIN
	# TODO: Put LAZY_BIN to PATH

	print("To continue, press any key, or Ctrl-C to exit")
	input()
	client.images.pull(IMAGE_TAG)

print('image:', img_tag)
container_name = None
for container in client.containers.list():
	if img_tag not in container.image.tags:
		continue
	container_name = container.name
	break

if container_name is None:
	# run a container
	print('No container found, create one, with config below')
	container_name = 'lazybox' if IS_DEV else img_tag.replace(':', '_')
	config = {
		'image': img_tag,
		'command': '/bin/cat',	    # doesn't stop
		'name': container_name,
		'volumes': {
			HOME: {'bind': '/root/workspace', 'mode': 'rw'},
			DESKTOP: {'bind': '/root/desktop', 'mode': 'rw'},
			# LAZY_HOME: {'bind': '/root', 'mode': 'rw'},		# doesn't work
			# TODO: auto loop disk and create corresponding volume drive
			'D://': {'bind': '/root/drive/d', 'mode': 'rw'},
			'C://': {'bind': '/root/drive/c', 'mode': 'rw'}
		},
		'network': 'host',	    	# export all port, internal network will be mapped out
		'working_dir': '/root',	    # use as root
		'restart_policy': {	    	# auto start on startup
			'Name': 'always',
		},
		'tty': True,
		'detach': True		    	# run in detach mode
	}
	pprint(config, indent=4)
	client.containers.run(**config)
print('container:', container_name)

home = HOME.replace('\\', '/')
current_dir = os.getcwd().replace('\\', '/')

if 'D:/' in current_dir:
	docker_dir = current_dir.replace('D:/', '/root/drive/d/')
elif home in current_dir:
	docker_dir = current_dir.replace(home, '/root/workspace/')
elif 'C:/' in current_dir:
	docker_dir = current_dir.replace('C:/', '/root/drive/c/')
else:
	docker_dir = '/root'

# TODO: create a more interactive start point
cmd = "docker exec -w {} -it {} /bin/bash".format(docker_dir, container_name)
print(cmd)
subprocess.call(cmd, shell=True)
