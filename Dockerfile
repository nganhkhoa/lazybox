FROM archlinux/base:latest

ARG user=docker

COPY resource /root/resource
RUN /root/resource/setup/add-aur.sh $user
RUN /root/resource/setup/install.sh $user

USER $user
