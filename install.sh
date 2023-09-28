#---------------------- ZSH setup alongwith manjaro config, oh-my-zsh and p10k----------------------#

sudo pacman -Sy zsh git
ln -s $HOME/.dotfiles/.manjaro-config $HOME/.manjaro-config
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 
#----------------------------------------------------------------------------------------------------#

#----------------------------------------- NVIM Setup -----------------------------------------------#

mkdir $HOME/.config
ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
#----------------------------------------------------------------------------------------------------#


#---------------------------------------- Kitty Conf ------------------------------------------------#

sudo pacman -Sy kitty
ln -s $HOME/.dotfiles/kitty $HOME/.config/kitty
#----------------------------------------------------------------------------------------------------#
