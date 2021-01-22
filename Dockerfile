FROM ubuntu:latest

SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update && apt-get install -y git wget curl sudo rsync locales

# Locale is set in .bash_profile; needs to be created
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

# From now on, use login shell so that bashrc gets sourced
ENV SHELL /bin/bash

# Get this installed up front out of the way without prompting for a region
# (which otherwise hangs the build)
RUN DEBIAN_FRONTEND=noninteractive apt-get install tzdata

ADD . dotfiles
WORKDIR dotfiles

# Run setup in order

ENV DOTFILES_FORCE=true
RUN ./setup.sh --apt-get-installs-minimal
RUN ./setup.sh --dotfiles
RUN apt-get install -qy neovim
RUN ./setup.sh --set-up-vim-plugins
RUN nvim +PlugInstall +qall

RUN echo $HOME
RUN source $HOME/.aliases


# Various installations using ./setup.sh
RUN ./setup.sh --install-fzf
RUN ./setup.sh --install-hub
RUN ./setup.sh --install-icdiff
RUN ./setup.sh --install-jq

ENTRYPOINT ["/bin/bash"]
