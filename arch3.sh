#!/bin/bash
#rm -rf ~/.config/xfce4/*
#mkdir ~/Downloads
#cd ~/Downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка программ'
sudo pacman -S firefox ufw qt4 alsa-lib alsa-utils file-roller p7zip unrar aspell-ru pulseaudio pavucontrol --noconfirm

echo 'Установить рекомендумые программы?'
read -p "1 - Да, 0 - Нет: " prog_set
if [[ $prog_set == 1 ]]; then
  sudo pacman -S vlc freemind filezilla gimp libreoffice libreoffice-fresh-ru audacity qbittorrent galculator --noconfirm
  yay -S cherrytree timeshift flameshot-git hunspell-ru pamac-aur --noconfirm 
  gpg --keyserver pgp.mit.edu --recv-keys FC918B335044912E
elif [[ $prog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi
  
echo 'Убираем меню граб для выбора системы?'
read -p "1 - Да, 0 - Нет: " grub_set
if [[ $grub_set == 1 ]]; then
  wget git.io/grub.tar.gz
  sudo tar -xzf grub.tar.gz -C /
  sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $grub_set == 0 ]]; then
  echo 'Пропускаем.'
fi

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/arch3.sh

echo 'Установка завершена!'
