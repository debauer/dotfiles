#!/usr/bin/env zsh

echo "Cloning own prezto setup"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

echo "Configuring rc-files"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

_dircolors_folder="${HOME}/.dir_colors"
echo "Downloading solarized dircolors to $_dircolors_folder"
mkdir -p "$_dircolors_folder"
curl \
    --output "$_dircolors_folder/dircolors" \
    --show-error \
    --silent \
    --location \
    https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

echo "Changing default shell"
sudo chsh -s "$(which zsh)"

if which poetry &> /dev/null ; then
    echo "Adding poetry completions to zprezto..."
    poetry completions zsh > "${HOME}/.zprezto/modules/completion/external/src/_poetry"

    echo "Forcing rebuild of completions..."
    rm -rf "${HOME}/.zcompdump"
    compinit
fi

echo "All done, restart your shell to see the effect"
echo "Consider running 'zprezto-update' to get the latest changes"
