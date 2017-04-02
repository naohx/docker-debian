FROM debian:testing

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y aptitude && aptitude install -y sudo apt-utils openssh-server vim zsh tmux git gcc g++ tig sshfs reptyr golang locales-all man
ENV DEBIAN_FRONTEND dialog
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# user settings
ENV HOSTNAME debian
ENV USERNAME toshi
RUN adduser $USERNAME
ENV HOME /home/$USERNAME
RUN echo "toshi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "toshi:toshi" | chpasswd
RUN sed -i -e 's/toshi:x:1000:1000:,,,:\/home\/toshi:\/bin\/bash/toshi:x:1000:1000:,,,:\/home\/toshi:\/bin\/zsh/g' /etc/passwd
USER $USERNAME

ENV XDG_CONFIG_HOME $HOME/.config
WORKDIR ${HOME}
RUN git clone https://github.com/caustic-soda/dotfiles.git
RUN git clone https://github.com/caustic-soda/nvimprod.git
WORKDIR ${HOME}/dotfiles
RUN ./ln.sh
RUN ./apt.sh
WORKDIR ${HOME}/nvimprod
RUN ./install.sh
RUN mkdir -p $HOME/develop/golang
RUN touch $HOME/.zlogin
RUN echo "export GOPATH=$HOME/develop/golang" >> $HOME/.zlogin
WORKDIR ${HOME}

CMD tmux
