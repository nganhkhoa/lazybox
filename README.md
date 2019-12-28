# LAZY BOX

A Docker Box for my personal development environment and CTF competitions

## Install

Needs docker and python3.7 and below, python3.8 docker doesn't work.

```sh
pip install docker
python lazy.py
```

It will

- pull luibo/lazybox
- create a container that have a config like below
```
  config = {
    'image': img_tag,
    'command': '/bin/cat',          # doesn't stop
    'name': container_name,
    'volumes': {
      HOME: {'bind': '/root/workspace', 'mode': 'rw'},
      DESKTOP: {'bind': '/root/desktop', 'mode': 'rw'},
      **drives                      # mapping drives to /root/drives/*
    },
    'network': 'host',              # export all port, internal network will be mapped out
    'working_dir': '/root',         # use as root
    'restart_policy': {             # auto start on startup
      'Name': 'always',
    },
    'tty': True,
    'detach': True                  # run in detach mode
  }
```
- [TODO] set registry key to use python3 to exec this script
- [TODO] copy to ~/lazy/bin
- [TODO] add ~/lazy/bin to PATH

After the container is run, running lazy will result in a bash shell. It will drop you in the folder you are on.

Others commands are `-w` `-d` `-e` follows by `cmd`.

```
-w      set working directory
-d      use default command
-e      run detach
```

## Use cases

```
ps1> lazy
# will spawn a shell in container at cwd
ps1> lazy nvim
# quickly run nvim at cwd
ps1> lazy -e nvim --headless --listen 0.0.0.0:4444
# start a nvim server at docker interface, which you can go to your browser on 10.0.75.*:4444
# and this detach too
ps1> lazy python somefile.py
# quickly run python script
# or any other script, you have node/ruby/crystal/golang
```
