# Doregon's Java Edition Repository

*Maybe Microsoft will take a hint!*

This repository is an unofficial APT server for Minecraft: Java Edition.

![](assets/sudo-apt-upgrade.jpeg)

## Features

- Update Minecraft using APT!
- Searches for new Launcher updates every hour
- No external routes, straight from launcher.mojang.com!
- Keeps old Launcher versions, in case they are needed
- Easy install script
- Open-source (obviously)
- Available to all

## Installation

To add this APT repository to your sources and automatically update your package lists, run the following command in your terminal:

`curl -fsSL 'https://raw.githubusercontent.com/Doregon/minecraft-repo/main/install.sh' | bash`

Once the script completes, you can run   
If you don't have it: `sudo apt install minecraft-launcher`  
If you already have it: `sudo apt upgrade minecraft-launcher`

Specifying a version is easy too:  
`sudo apt install minecraft-launcher:<version>`

A list of versions can easily be found in the `Packages file on this repository.

## Security

None of the .deb files are modified when they get to this APT repository. All of the debs come straight from launcher.mojang.com, which is the link that you are sent to when you hit the "Download" button for the .deb file on the website. This is simply just an easier way to download the launcher without having to go to the website every single time.
