FROM archlinux/base:latest

ARG user=docker

COPY resource /lazybox/resource
RUN /lazybox/resource/setup/add-aur.sh $user
RUN /lazybox/resource/setup/install.sh $user

USER $user
