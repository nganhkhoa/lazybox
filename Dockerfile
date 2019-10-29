FROM archlinux/base:latest

COPY setup /root/setup
COPY config /root/.config
COPY home/bashrc /root/.bashrc

RUN /root/setup/add-aur.sh docker
RUN /root/setup/install.sh
