

function install_ssh {
    mkdir .ssh
    if [[ ! -f .ssh/id_ed25519 ]]; then
      ssh-keygen -t ed25519 -f .ssh/id_ed25519 -q -P ""
    fi
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiioystJieEq2Hkwl7efdIEwf3RMu81CkioXuu7Qjrv debauer@debauer-synyx" > .ssh/authorized_keys
}
  
function install_zsh {
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone https://github.com/debauer/dotfiles .dotfiles
    rm .config/htop/htoprc
    rm .bashrc
    rm .bash_profile
    rm .zshrc
    cd .dotfiles
    stow shell
}

function install_yay {
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
}

pacman -Syu --noconfirm stow zsh git wget openssh rsync base-devel python htop

systemctl start sshd   
systemctl enable sshd

curl -sSL https://install.python-poetry.org | python3 -

useradd debauer
mkdir /home/debauer
chown debauer /home/debauer
sudo usermod -a -G wheel debauer
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
cd 
install_ssh
install_zsh

su debauer
cd 
install_ssh
install_zsh
install_yay