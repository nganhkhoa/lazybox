FROM archlinux/base:latest

COPY setup /root/setup
COPY config /root/.config
COPY home/bashrc /root/.bashrc
COPY home/bowerrc /root/.bowerrc

RUN /root/setup/add-aur.sh docker
RUN /root/setup/install.sh
