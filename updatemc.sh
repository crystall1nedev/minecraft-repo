#! /bin/bash

# Commented out for GitHub workflow. Only used locally if required.
# cd /home/doregon/git/minecraft-repo

# This file is simply how the APT repository can automatically grab the latest
# version of Minecraft.deb from the official website. This is also how you know
# that you can trust this source, free of malware and corrupted files :)
# Since this is actually a file to be run in crontab rather than directly, we'll
# be using variables and if statements to run it correctly.

# This APT repository is going to have multiple versions of the Minecraft Launcher.
# This is the variable we'll use to check the version against what's online.
LVERSION=$(ar p debs/Minecraft-latest.deb control.tar.gz | tar xzOf - ./control | grep Version | cut -b 10-68)

# This is the variable we'll use for the version number of the online .deb.
curl https://launcher.mojang.com/download/Minecraft.deb -o debs/tempdeb.deb
RVERSION=$(ar p debs/tempdeb.deb control.tar.gz | tar xzOf - ./control | grep Version | cut -b 10-68)

# The actual code, checking to see if the version numbers are the same.
if [[ $LVERSION != $RVERSION ]] 
then
   # Simple verification test to see if the file is complete.
   LFMD5=$(md5sum debs/Minecraft-latest.deb | awk '{ print $1 }')
   RFMD5=$(curl -sL https://launcher.mojang.com/download/Minecraft.deb | md5sum | cut -d ' ' -f 1)
   while [[ $LFMD5 != $RFMD5 ]]
   do
      # Moving stuffs
      mv debs/Minecraft-latest.deb debs/Minecraft-$LVERSION.deb
      mv debs/tempdeb.deb debs/Minecraft-latest.deb
      LFMD5=$(md5sum debs/Minecraft-latest.deb | awk '{ print $1 }')
      LVERSION=$(ar p debs/Minecraft-latest.deb control.tar.gz | tar xzOf - ./control | grep Version | cut -b 10-68)
   done
   # Packages & Packages.gz
   dpkg-scanpackages --multiversion . > Packages
   gzip -k -f Packages

   # Release, Release.gpg & InRelease
   apt-ftparchive release . > Release
   gpg --default-key "tunnic.adam@gmail.com" -abs -o - Release > Release.gpg
   gpg --default-key "tunnic.adam@gmail.com" --clearsign -o - Release > InRelease

   # Commit & push. Only used locally is GitHb Actions stops working.
   # git add -A
   # git commit -m "Update launcher to $RVERSION"
   # git push
  
   echo "Even cooler beans!"
else
   
   echo "Cool beans"

fi
