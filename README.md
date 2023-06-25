General Info:

This script is an automated subdomain enumeration tool.
When you run the script, it takes in a domain name, scans for subdomains, takes screenshots of any alive subdomains found and also asks if you want to visit those subdomains via Firefox.
This script makes use of many community made tools that are widely available here on GitHub, such as crt.sh, assetfinder, subfinder, gowitness and many others.
Just run the script and follow along as you might get prompted for some minor input.
I made this script as a way of automating subdomain reconnaissance, as well as a way for me to practice some basic bash scripting, as I felt inspired by TCM's subdomain enumeration bash script.
Feel free to take a look at the file and uncomment some lines, but do note that it will take significantly longer for the script to finish running in that case.

Script has only been fully tested only on Kali linux.

Installation & Usage:
1) git clone https://github.com/H1dd3n00b/SubHound.git
2) cd SubHound/Scripts
3) chmod +x *
4) ./DependenciesInstall.sh
5) Wait for everything to install ...
6) ./SubHound.sh
7) Type in the domain you want to scan for subdomains
8) Follow the script instructions, your terminal screen will be cleared occassionnally, this is intended...
9) Script takes about 1-5 minutes to complete
10) ENJOY!

COMMON ISSUES:
You won't be able to open all found subdomains in firefox if you are running the script as sudo. To fix this, just copy the SubHound.sh script to anywhere (for example your Desktop) and run it normally (not as sudo) from there.
If crt.ch outputs 0 subdomains found, try running the script again after a few minutes.

