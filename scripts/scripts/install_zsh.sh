apt install zsh stow
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/debauer/dotfiles .dotfiles
rm .config/htop/htoprc
rm .bashrc
rm .bash_profile
rm .zshrc
cd .dotfiles
stow shell

echo "run on client:"
echo "rsync -rPv .oh-my-zsh/custom/* debauer@pidisplay:/home/debauer/.oh-my-zsh/custom"