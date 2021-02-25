FROM amazonlinux:2

SHELL ["/bin/bash", "--login", "-c"]

RUN yum -y install git wget curl sudo rsync locales htop vim which go
RUN yum -y install tar
# Locale is set in .bash_profile; needs to be created
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

# From now on, use login shell so that bashrc gets sourced
ENV SHELL /bin/bash
ADD . dotfiles
WORKDIR dotfiles

# Run setup in order

ENV DOTFILES_FORCE=true
RUN ./setup.sh --dotfiles
RUN ./setup.sh --set-up-vim-plugins

# Various installations using ./setup.sh
RUN ./setup.sh --install-fzf
RUN ./setup.sh --install-hub
RUN ./setup.sh --install-icdiff
RUN ./setup.sh --install-jq

ENTRYPOINT ["/bin/bash"]
