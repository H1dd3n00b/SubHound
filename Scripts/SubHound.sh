#!/bin/bash

#Defining colors for prettier output
RED='\033[0;31m'
NC='\033[0m' #No color
BRIGHT_RED='\033[1;31m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_ORANGE='\033[1;33m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_VIOLET='\033[1;35m'
BRIGHT_WHITE='\033[1;37m'

echo -ne "${BRIGHT_WHITE}Enter the URL whose subdomains you wish to enumarate, save unique output to text files, take screenshots and check for possible subjacking: ${NC}"
read url
echo -e "${BRIGHT_ORANGE}========================================================================${NC}"
echo -e "URL you've chosen: ${BRIGHT_VIOLET}$url${NC}"
echo -e "${BRIGHT_ORANGE}========================================================================${NC}"
sleep 1
echo -e "${BRIGHT_BLUE}Pinging target to ensure future scan will go through...${NC}"
if ping -c 1 -W 1 "$url" >/dev/null
then
  echo -e "${BRIGHT_GREEN}Target is alive! Proceeding with scans...${NC}"
else
  echo -e "${BRIGHT_RED}Target is unreachable. Stopping the script.${NC}"
  echo -e "${BRIGHT_WHITE}Make sure you've ran the DependenciesInstall.sh in case you haven't already!${NC}"
  exit 1
fi
echo -e "${BRIGHT_ORANGE}------------------------------------------------------------------------${NC}"
if [ ! -d "$url" ]
then
	echo -e "All your scan results will be stored inside of the ${BRIGHT_VIOLET}$url${NC} directory."
        mkdir $url
elif [ -d "$url" ]
then
        echo -e "${BRIGHT_RED}The $url directory already exists!${NC}"
        echo "Perhaps you've already scanned it today?"
	sleep 0.5
        echo -e "Please make sure there isn't another directory named ${BRIGHT_VIOLET}$url${NC} so we may proceed with our scans."
	exit 1
fi
sleep 1
cd $url
echo -e "${BRIGHT_BLUE}Hunting for subdomains using subfinder...${NC}"
sleep 1
subfinder -d $url -silent -nW -o $url.subfinder1.txt
cat $url.subfinder1.txt | sort -u >> $url.subfinder.txt
echo "Done!"
sleep 0.5
echo "Cleaning up..."
sleep 1
rm $url.subfinder1.txt
clear
#echo -e "${BRIGHT_BLUE}Fuzzing for subdomains with gobuster by checking for the most common 5000 subdomains...${NC}"
#echo -e "${BRIGHT_WHITE}This might take a while...${NC}"
#sleep 1
#gobuster dns -d $url -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -t7 -o gobuster.txt -q; cat gobuster.txt | sed -r 's/\x1B\[[0-9;]*[JKmsu]//g; s/Found: //' >> cleangobuster.txt; cat cleangobuster.txt | grep -v -e '^$' -e '^\s*$' >> $url.gobuster.txt
#echo "If that took way too long, try increasing the "-t" parameter inside of the script."
#echo "Be wary though, as it is known to cause performance issues..."
#sleep 2
#echo "Done!"
#echo "Cleaning up..."
#sleep 2
#clear
#sleep 1
#rm gobuster.txt cleangobuster.txt
#echo "Done!"
#sleep 1
echo -e "${BRIGHT_BLUE}Starting assetfinder recon and sorting only unique results...${NC}"
assetfinder $url | sort -u >> $url.assetfinder.txt
echo "Done!"
echo -e "${BRIGHT_BLUE}Starting crt.sh subdomain search...${NC}"
echo -e "${BRIGHT_WHITE}You might get prompted for your password here...${NC}"
sleep 0.5
mkdir output
sleep 1
sudo /opt/crt.sh/./crt.sh -d $url
sleep 2
cp output/domain.$url.txt .
sleep 2
rm -rf output
mv domain.$url.txt $url.crt.sh.txt
echo "Done!"
sleep 0.5
echo "Cleaning up..."
sleep 0.5
clear
#echo -e "${BRIGHT_BLUE}Finding subdomains with amass ...${NC}"
#echo "This will take some time... make yourself comfortable..."
#amass enum -d $url >> amass.txt | sort -u amass.txt >> $url.amass.txt
#sleep 1
#rm amass.txt
#echo "Done"
echo -e "${BRIGHT_BLUE}Filtering out duplicates and leaving only unique subdomains...${NC}"
cat *.txt | sort -u >> $url.subs.txt
#rm $url.assetfinder.txt $url.subfinder.txt $url.crt.sh.txt
#sleep 1
#rm $url.gobuster.txt
echo "Done!"
echo -e "${BRIGHT_BLUE}Filtering out dead subdomains and leaving only alive subdomains by using httprobe...${NC}"
cat $url.subs.txt | httprobe -s -p https:443 >> $url.alivesubs.txt
cat $url.alivesubs.txt | awk -F'[:/]' '{gsub(/^https?:\/\//, "", $0); gsub(/:443$/, "", $0); print}' $url.alivesubs.txt > $url.final1.txt
sleep 1
cat $url.final1.txt | sort -u > $url.final.txt
rm $url.final1.txt
echo "Done!"
echo -e "${BRIGHT_BLUE}Taking screenshots of unique and alive subdomains with gowitness...${NC}"
sleep 1
gowitness scan file -f $url.final.txt
sleep 1
sudo chmod 777 screenshots/
sleep 0.5
echo "Done!"
echo -e "${BRIGHT_BLUE}Checking for potential subdomain takeover with subjack...${NC}"
subjack -w $url.final.txt -v >> $url.subjack.txt
echo "Done!"
echo "Results are out! See for yourself:"
echo -e "${BRIGHT_ORANGE}------------------------------------------------------------------------${NC}"
cat $url.subjack.txt
echo -e "${BRIGHT_ORANGE}------------------------------------------------------------------------${NC}"
sleep 1
echo "Performing a quick whois lookup on the target $url"
whois $url > $url.whoisinfo.txt
echo "Done!"
sleep 0.5
echo "All WHOIS results are stored inside $url.whoisinfo.txt"
sleep 0.5
#echo -e "${BRIGHT_BLUE}Starting katana, an ultra-fast web crawler for found valid subdomains on the list...${NC}"
#katana -list $url.final.txt -o $url.katana.txt
#sleep 1
echo "Done!"
echo -e "${BRIGHT_WHITE}Would you like to take a look at the alive subdomains in your Firefox browser? (y/n)${NC}"
read answer
if [ $answer = "y" ] || [ $answer = "Y" ]
then
	original_owner=$(stat -c %U $XAUTHORITY)
   	original_group=$(stat -c %G $XAUTHORITY)
       	sudo chown root:root $XAUTHORITY
       	sleep 2
	echo "Opening found alive subdomains in a separate tab in Firefox..."
	sleep 2
	sudo nohup firefox $(cat $url.final.txt) >/dev/null 2>&1 &
	sleep 2
	sudo chown "$original_owner":"$original_group" $XAUTHORITY
	sleep 2
elif
	[ $answer = "N" ] || [ $answer = "n" ]
then
	echo "As you wish..."
	sleep 1
else
	echo -e "${BRIGHT_ORANGE}-------------------------------------------------------------------${NC}"
	echo -e "${BRIGHT_RED}Invalid input. Next time, try using any of the following: Y,y,N,n.${NC}"
	echo -e "${BRIGHT_ORANGE}-------------------------------------------------------------------${NC}"
	sleep 2
fi
echo "Cleaning up..."
sleep 1
#clear
echo "All done!"
sleep 1
echo "Your results can be observed below"
echo -e "${RED}========================================================================${NC}"
ls -la

echo -e "${RED}========================================================================${NC}"
echo -e "${BRIGHT_WHITE}The final list of alive and unique subdomains is contained within the file called "${BRIGHT_RED}$url.final.txt${NC}""
echo ""
sleep 0.5
echo -e "${BRIGHT_WHITE}All the other files contain subdomains that might not be around anymore, discovered by other tools this script relies on.${NC}"
sleep 0.5
echo -e "${BRIGHT_WHITE}In case you haven't found what you were looking for, try and edit this script by uncommenting some of the lines above. Perhaps you might get more successful hits that way!${NC}"
sleep 0.5
echo "Please keep in mind that you might run into performance issues if you decide to go down that road."
sleep 0.5
echo -e "${BRIGHT_ORANGE}For more,${BRIGHT_VIOLET} please visit:${BRIGHT_RED} https://github.com/H1dd3n00b${NC}"
sleep 1
echo "Thanks for using my script!"
sleep 0.5
echo "Good luck and happy hacking!"
sleep 0.5
