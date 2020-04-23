# LAZY BOX

A Docker Box for my personal development environment and CTF competitions

## Install

Needs docker and python3.8 above (because f string is great).

```sh
pip install docker
python lazy.py
```

Make sure that you give docker permission to folders, change folder to skip mapping in lazy.py

```python
NOT_SHARE_DRIVES = 'EGF'
```

Lazy.py will

- pull luibo/lazybox
- create a container that have a config like below
```python
  config = {
    'image': img_tag,
    'command': '/bin/cat',          # doesn't stop
    'name': container_name,
    'volumes': {
      HOME: {'bind': f'{CONTAINER_WORKSPACE}/workspace', 'mode': 'rw'},
      DESKTOP: {'bind': f'{CONTAINER_WORKSPACE}/desktop', 'mode': 'rw'},
      **drives
    },
    # 'network': 'host',              # export all port, internal network will be mapped out
    # 'network_mode': 'host',
    # 'publish_all_ports': True,
    # docker no longer support IP for container, and recommend using port exposing
    'ports': {
      '8000/tcp': '8000',
      '8080/tcp': '8080',
      '3000/tcp': '3000',
      '4444/tcp': '4444',
      # '9000/tcp': '9000',
    },
    'working_dir': f'{CONTAINER_WORKSPACE}',         # use as root
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

After the container is run, `lazy` will result in a bash shell. It will drop you in the folder you are on.

Others commands are `-w` `-d` `-e` follows by `cmd`.

```
-w      set working directory
-d      use default command
-e      run detach
```

## Use cases

Detaching is not well written, and default commands must be edited inside the lazy.py script.

```
ps1> lazy
# will spawn a shell in container at cwd
ps1> lazy nvim
# quickly run nvim at cwd
ps1> lazy -e nvim --headless --listen 0.0.0.0:4444
# start a nvim server at docker interface
# and this detach too
ps1> lazy python somefile.py
# quickly run python script
# or any other script, you have node/ruby/crystal/golang
```

Docker remove ip for container (10.0.75.<number>), so we have to export some ports by default,

I exports common ports:
- 3000
- 4444
- 8000
- 8080
- 9000, up to you

## Build

Change version tag and `IS_DEV`, `DEV_IMAGE_TAG` to use if you are using a dev image on your own.

```
docker build --tag luibo/lazybox:v0.5 --build-arg user=luibo .
```

## This container provides

Tools for programmings: git, make, cmake, (neo)vim, openssh

Extra tools for programmings: gdb, diff-so-fancy

Tools: wget, curl, ripgrep, fzf, httpie, bat, exa, wakatime

Extraction tools: p7zip, unrar, unzip, zip, unarchiver, bzip2, gzip, lrzip, lz4, lzip, lzop, xz, tar

We also have `unp` an interface for unpacking using the above tools, not tested though

Debugger: gdb, radare2

Programming languages/compilers: gcc, clang, python, python3, nodejs, crystal-lang, ruby, golang, rust, elixir, haskell, scala, clojure, racket

Even more programmings languages/compilers: typescript, coffeescript, purescript, reasonML, coconut

Texlive is also installed!

Some frequently used nodejs modules are installed too: express (koa), lodash, ramda, react

Programming contest tools: getac (minimal testing tool), exercism

Tools for CTFs: sagemath, yafu, pwntools, pycryptodome, z3, apktool, jadx, volatility
