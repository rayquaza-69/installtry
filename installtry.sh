
echo "Username: "
read username

echo "Grub-device (/dev/sdx): "
read disk

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/local.conf

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
pacman -S ntp --noconfirm --needed
systemctl enable --now ntpd

echo "Archbox" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1     localhost" >> /etc/hosts
echo "127.0.1.1 Archbox@localdomain Archbox" >> /etc/hosts

pacman -S grub efibootmgr mtools dosfstools xdg-user-dirs xdg-utils --noconfirm --needed


grub-install --target=i386-pc $disk
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager xdg-utils xdg-user-dirs --needed --noconfirm
systemctl enable --now NetworkManager.service


useradd -mG wheel,audio,video,optical,tty,network,storage $username
echo "password for user"
passwd $username

echo "password for root"
passwd

echo "root ALL=(ALL) ALL" > /etc/sudoers
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "@includedir /etc/sudoers.d" >> /etc/sudoers

pacman -S sudo --noconfirm

pacman -S fish --noconfirm
chsh -s /usr/bin/fish $username


pacman -S doas --needed --noconfirm
echo "permit :wheel" >> /etc/doas.conf

