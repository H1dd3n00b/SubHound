## General Info:

This script is an automated subdomain enumeration tool.

When you run the script, it takes in a domain name, scans for subdomains, takes screenshots of any alive subdomains found and also asks if you want to visit those subdomains via Firefox.

This script makes use of many community made tools that are widely available here on GitHub, such as crt.sh, assetfinder, subfinder, gowitness and many others.
Just run the script and follow along as you might get prompted for some minor input.

I made this script as a way of automating subdomain reconnaissance, as well as a way for me to practice some basic bash scripting, as I felt inspired by TCM's subdomain enumeration bash script.
Feel free to take a look at the file and uncomment some lines, but do note that it will take significantly longer for the script to finish running in that case.

Script has only been fully tested only on Kali linux.

## Installation & Usage:

```
1) Clone the repository:
git clone https://github.com/H1dd3n00b/SubHound.git
2) Navigate to the Scripts directory:
cd SubHound/Scripts
3) Make the scripts executable:
chmod +x *
4) Install the dependencies:
./DependenciesInstall.sh
5) Run the script (avoid using sudo to prevent interference with Firefox):
./SubHound.sh
6) Enter the domain you want to scan for subdomains when prompted.
7) Follow the instructions provided by the script. The terminal screen may be cleared occasionally, which is intended.
```
Enjoy using SubHound!

Note: It is recommended not to run the script with sudo as it may affect the functionality of Firefox.

## KNOWN ISSUES:
```
You won't be able to open all found subdomains in Firefox if you are running the script as sudo. To fix this, follow these steps:

Copy the SubHound.sh script to a location of your choice (e.g., your Desktop).
Make sure you are not running the script with sudo privileges.
Open a terminal and navigate to the location where you copied the SubHound.sh script.
```
