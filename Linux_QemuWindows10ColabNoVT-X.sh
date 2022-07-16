useradd -m user
adduser user sudo
echo 'user:root' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
read -p "Paste auth here (Copy and Ctrl+V to paste then press Enter): " CRP
echo "Please wait for installing..."
sudo apt update -y > /dev/null 2>&1
echo "Installing QEMU (2-3m)..."
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1
echo Downloading Windows Disk...
curl -L -o lite10.qcow2 https://app.vagrantup.com/thuonghai2711/boxes/WindowsQCOW2/versions/1.1.3/providers/qemu.box
echo "Windows 10 x64 Lite On Google Colab"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
sudo qemu-system-x86_64 -vnc :0 -hda lite10.qcow2  -smp cores=8  -m 10000M -machine usb=on -device usb-tablet > /dev/null 2>&1

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
dpkg --install chrome-remote-desktop_current_amd64.deb
apt install --assume-yes --fix-broken
adduser user chrome-remote-desktop
su - user -c $CRP --pin=123456
service chrome-remote-desktop start
