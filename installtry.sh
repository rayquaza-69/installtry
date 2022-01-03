
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

useradd -mG wheel,audio,video,optical,tty,network,storage $user
echo "password for user"
passwd $user

echo "password for root"
passwd


