#! /bin/bash

   dpkg-scanpackages --multiversion . > Packages
   gzip -k -f Packages

   # Release, Release.gpg & InRelease
   apt-ftparchive release . > Release
   gpg --default-key "tunnic.adam@gmail.com" -abs -o - Release > Release.gpg
   gpg --default-key "tunnic.adam@gmail.com" --clearsign -o - Release > InRelease
