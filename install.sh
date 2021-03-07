curl -s --compressed "https://doregon.github.io/minecraft-repo/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/doregonrepo.list "https://doregon.github.io/minecraft-repo/aptsource.list"
sudo apt update 
