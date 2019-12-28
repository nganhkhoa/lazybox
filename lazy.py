# make sure that in cmd
# ftype Python.File
# returns python3 path
# change HKEY_CLASSES_ROOT\Python.File\shell\open\command to python3 binary

import argparse
import os
import sys
import subprocess

import win32api
import docker

from typing import List, Dict
from os.path import expanduser
from functools import reduce
from winreg import OpenKey, CloseKey
from pprint import pprint

IS_DEV = True
DEV_IMAGE_TAG = 'luibo/lazybox:v0.3'
IMAGE_TAG = 'luibo/lazybox'
IMAGE_NOT_EXIST = 1
IMAGE_EXIST = 2
HOME = expanduser('~')
DESKTOP = f'{HOME}\Desktop'
CMD_FORMAT = 'docker exec -w \"{}\" -it {} bash -l -c \"{}\"'
NOT_SHARE_DRIVES = 'EG'

CONTAINER_USERNAME = 'luibo'
if CONTAINER_USERNAME == 'root':
  CONTAINER_WORKSPACE = '/root'
else:
  CONTAINER_WORKSPACE = f'/home/{CONTAINER_USERNAME}'

# lazy data
LAZY = f'{HOME}\lazy'
LAZY_BIN = f'{LAZY}\\bin'

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
  print('It seems this is your first time')
  print('We will')
  print('[+] Pull the luibo/lazybox image')
  print(f'[+] Run a container that maps {HOME} and drives to {CONTAINER_WORKSPACE}/workspace and {CONTAINER_WORKSPACE}/drive/*')
  print('[+] Fix registry entry at HKEY_CLASSES_ROOT\Python.File\shell\open\command to python3 installation path')
  print(f'[+] Put this script at {LAZ_BIN} and add to PATH')

  # TODO: Fix registry value
  # TODO: Put script at LAZY_BIN
  # TODO: Put LAZY_BIN to PATH

  print('To continue, press any key, or Ctrl-C to exit')
  input()
  client.images.pull(IMAGE_TAG)

print('image:', img_tag)
container_name = None
for container in client.containers.list():
  if img_tag not in container.image.tags:
    continue
  container_name = container.name
  break

# find drives
drives_list = win32api.GetLogicalDriveStrings().split('\\\x00')[:-1]
drives_list = filter(lambda d: d[0] not in NOT_SHARE_DRIVES, drives_list)
drives = list(map(lambda d: {
  f'{d}//': {'bind': f'{CONTAINER_WORKSPACE}/drive/{d[0].lower()}', 'mode': 'rw'}
}, drives_list))
drives = reduce(lambda acc, item: {**acc, **item}, drives, {})

if container_name is None:
  # run a container
  print('No container found, create one, with config below')
  container_name = 'lazybox' if IS_DEV else img_tag.replace(':', '_')
  config = {
    'image': img_tag,
    'command': '/bin/cat',          # doesn't stop
    'name': container_name,
    'volumes': {
      HOME: {'bind': f'{CONTAINER_WORKSPACE}/workspace', 'mode': 'rw'},
      DESKTOP: {'bind': f'{CONTAINER_WORKSPACE}/desktop', 'mode': 'rw'},
      **drives
    },
    'network': 'host',              # export all port, internal network will be mapped out
    'working_dir': f'{CONTAINER_WORKSPACE}',         # use as root
    'restart_policy': {             # auto start on startup
      'Name': 'always',
    },
    'tty': True,
    'detach': True                  # run in detach mode
  }
  pprint(config, indent=4)
  client.containers.run(**config)
print(f'container: {container_name}')

def process_cwd(d):
  # direct access to docker container
  # if '/root' == d[:5]:
  #   return d
  if '~' == d[0]:
    return f'{CONTAINER_WORKSPACE}{d[1:]}'

  d = os.path.abspath(d)
  d = d.replace('\\', '/')
  # access to local drive
  for drive in filter(lambda c: c != 'C:', drives_list):
    drive_name = f'{drive}/'
    if drive_name in d:
      return d.replace(drive_name, f'{CONTAINER_WORKSPACE}/drive/{drive_name.lower()[0]}/')

  # special case C:/ home directory
  home = HOME.replace('\\', '/')
  if home in d:
    return d.replace(home, f'{CONTAINER_WORKSPACE}/workspace/')
  elif 'C:/' in d:
    return d.replace('C:/', f'{CONTAINER_WORKSPACE}/drive/c/')
  # if path not found than go to USERWORKSPACE
  return CONTAINER_WORKSPACE

if len(sys.argv) == 1:
  # short command lazy
  print('Default command will open lazybox at current directory')
  docker_dir = process_cwd(os.getcwd())
  cmd = CMD_FORMAT.format(docker_dir, container_name, 'bash')
  print(cmd)
  subprocess.call(cmd, shell=True)
  exit()

# verbose command, gives more control
parser = argparse.ArgumentParser(description='Lazybox full command')
parser.add_argument('cmd', metavar='cmd', nargs='+',
                    help='command and arugments')
parser.add_argument('-w', metavar='cwd', type=str,
                    help='Where to operate this command, default to current directory')
parser.add_argument('-d', action='store_true',
                    help='default commands, edit lazy.py to your prefered lazy command')
parser.add_argument('-e', action='store_true',
                    help='start detatch?')
args = parser.parse_args()

if args.w is None:
  docker_dir = process_cwd(os.getcwd())
else:
  docker_dir = process_cwd(args.w)

default_cmd = {
  'nvim': 'nvim --headless --listen 0.0.0.0:4444'
}

if args.d is True:
  if args.cmd[0] in default_cmd:
    cmd = CMD_FORMAT.format(docker_dir, container_name, default_cmd[args.cmd[0]])
  else:
    raise Exception('Not a valid default command')
else:
  cmd = CMD_FORMAT.format(docker_dir, container_name, ' '.join(args.cmd))

# run command
print('detach: {} -- {}'.format(args.e, cmd))
if args.e is True:
  subprocess.Popen(cmd, stdin=None, stdout=None, stderr=None, close_fds=True, shell=False)
else:
  subprocess.call(cmd, shell=True)
