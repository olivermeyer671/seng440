# SENG440 Embedded Systems - Audio Compression and Decompression

## Setting up your machine:
1. clone the repository on your local machine using git clone
2. create a folder called vm in the cloned repo (mkdir vm)
3. download the three large missing files from the ece server while on the uvic VPN:
	- Fedora-Minimal-armhfp-29-1.2-sda.qcow2
	- initramfs-4.18.16-300.fc29.armv7hl.img
	- vmlinuz-4.18.16-300.fc29.armv7hl
4. move these files into the vm folder of the cloned repo 
4. run the virtual machine (./run.sh)
5. Login credentials:
	- username: root
	- password: seng440
6. to power the machine off: (poweroff)

## Editing project code:
	- There is a shared folder in /root/project/ that is linked to the cloned repo (/seng440/project/)
	- Any files in your local machine will be mirrored to this location and can be compiled on the virtual machine, or cross-compiled from your machine
 
