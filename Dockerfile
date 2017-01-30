FROM finalduty/archlinux
MAINTAINER Ulisses Bini de Paiva Alves <ulissesbpalves@gmail.com>

ENV TERM xterm-256color

RUN curl -fsSL "https://www.archlinux.org/mirrorlist/?country=BR&protocol=http&ip_version=4" \
    | cut -b 2- > /etc/pacman.d/mirrorlist \
  && pacman -Syu --noconfirm \
    git \
    zsh \
    tmux \
    neovim \
  && pacman -Scc --noconfirm \
  && git config --global user.name "Ulisses Bini de Paiva Alves" \
  && git config --global user.email "ulissesbpalves@gmail.com" \
  && mkdir ~/.config \
  && git clone https://github.com/ulisses-alves/dotfiles ~/.dotfiles --depth 1 \
  && ln -s ~/.dotfiles/less/.lesskey ~/.lesskey && lesskey \
  && ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf \
  && ln -s ~/.dotfiles/nvim ~/.config/nvim \
  && curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
  && nvim +PlugInstall +qa

COPY files/.zshrc /root/.zshrc
VOLUME /root/workspace
WORKDIR /root/workspace

CMD ["/usr/bin/zsh"]
