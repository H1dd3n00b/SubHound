#!/bin/bash

echo "This script installs all the dependencies you will need to successfully run the SubHound.sh script."
sleep 1
echo "This script assumes you are on a kali linux machine, and that you can run commands as sudo."
sleep 1
echo "This script will also occasionally clear your screen, so don't be alarmed!"
sleep 1
echo "In case you have something important stored on your terminal screen, now would be a good time to Ctrl+c out of this script..."
sleep 4
echo "You might also be prompted for input occassionally. If this happens, be sure to type in your password or "y" and press the return key."
sleep 1
echo "Initializing setup..."
echo "====================="
sleep 1
sudo apt update
sleep 1
echo "Installing golang-go..."
echo "======================="
sudo apt install golang-go -y
sleep 1
go install github.com/projectdiscovery/katana/cmd/katana@latest
echo "=============="
echo "Cleaning up..."
echo "=============="
sleep 2
clear
echo "Downloading Google Chrome as it does not come preinstalled on Kali and we need it for gowitness..."
echo "=================================================================================================="
echo "This might take a while..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sleep 1
echo "Installing Google Chrome as it does not come preinstalled on Kali, and we need it for gowitness..."
echo "=================================================================================================="
sudo apt install ./google-chrome-stable_current_amd64.deb -y
echo "=============="
echo "Cleaning up..."
echo "=============="
sleep 1
rm google-chrome-stable_current_amd64.deb
sleep 1
clear
echo "Installing gowitness..."
echo "======================="
go install github.com/sensepost/gowitness@latest
sleep 1
echo "Installing subfinder..."
echo "======================="
sudo apt install subfinder -y
sleep 1
echo "Installing gobuster..."
echo "======================"
sudo apt install gobuster -y
echo "=============="
echo "Cleaning up..."
echo "=============="
sleep 1
clear
echo "Installing SecLists..."
echo "======================"
sudo apt install seclists -y
sleep 1
echo "Installing httprobe..."
echo "======================"
sudo apt install httprobe -y
sleep 1
echo "Installing assetfinder..."
echo "========================="
sudo apt install assetfinder -y
sleep 1
echo "Installing subjack..."
echo "====================="
sudo apt install subjack -y
sleep 1
echo "Installing crt.sh straight into your /opt directory and enabling its execution..."
echo "================================================================================="
sudo git clone https://github.com/az7rb/crt.sh.git /opt/crt.sh
sudo chmod +x /opt/crt.sh/crt.sh
sleep 1
echo "Installing jq as its needed for crt.sh to function properly..."
echo "=============================================================="
sudo apt install jq -y
sleep 1
sudo cp /home/kali/go/bin/* /usr/bin
sleep 1
echo "=============="
echo "Cleaning up..."
echo "=============="
sleep 1
clear
echo "Phew! We are all done!"
sleep 1
echo "If you are seeing this message it means everything was installed successfully!"
echo "You can now freely run the SubHound.sh script. Hooray!"
sleep 1
echo "Thank you for using this script! Your screen will be cleared now. Goodbye."
sleep 4
clear
