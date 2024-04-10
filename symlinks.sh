cp -rs /home/han/.dotfiles/.config/lf /home/han/.config/ 
cp -rs /home/han/.dotfiles/.config/nvim /home/han/.config/ 
cp -rs /home/han/.dotfiles/.config/zathura /home/han/.config/
cp -rs /home/han/.dotfiles/.config/i3 /home/han/.config/
cp -rs /home/han/.dotfiles/.config/mpv /home/han/.config/
cp -rs /home/han/.dotfiles/.config/mimeapps.list /home/han/.config/

ln -s /home/han/.dotfiles/pacman.conf /etc/

ln -s /home/han/.dotfiles/.gitconfig /home/han/
ln -s /home/han/.dotfiles/.xinitrc /home/han/
ln -s /home/han/.dotfiles/.Xmodmap /home/han/
ln -s /home/han/.dotfiles/.Xresources /home/han/
ln -s /home/han/.dotfiles/.bashrc /home/han/
ln -s /home/han/.dotfiles/.bash_profile /home/han/

ln -s /home/han/.dotfiles/golink /usr/bin/
ln -s /home/han/.dotfiles/empty_trash /home/han/.local/bin/
