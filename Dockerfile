FROM finalduty/archlinux
MAINTAINER Ulisses Bini de Paiva Alves <ulissesbpalves@gmail.com>

# packages
RUN pacman -Syu --noconfirm \
  git \
  zsh \
  tmux \
  neovim \
  && pacman -Scc --noconfirm

# env
ENV TERM xterm-256color

RUN mkdir ~/.config
RUN git clone https://github.com/ulisses-alves/dotfiles ~/.dotfiles --depth 1

# git
RUN git config --global user.name "Ulisses Bini de Paiva Alves" \
  && git config --global user.email "ulissesbpalves@gmail.com"

# less
RUN ln -s ~/.dotfiles/less/.lesskey ~/.lesskey && lesskey

# tmux
RUN ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

# neovim
RUN ln -s ~/.dotfiles/nvim ~/.config/nvim
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim +PlugInstall +qa

# zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY .zshrc /root/.zshrc

# workspace
RUN mkdir /workspace
VOLUME /workspace
WORKDIR /workspace

# command
CMD ["/usr/bin/zsh"]
