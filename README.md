# BluePlayer
##Simple Bluetooth AVRC interface for Ubuntu
This project provides a simple AVRC terminal interface for Ubuntu, which allows the user to remotely control the media player running on a connected bluetooth device. It gives the user access to the basic media control functions, such as play, pause, next track and previous track, via simple terminal commands. It also notifies the user when the track currentrly played changes.

**IMPORTANT**
Change the content of the variable BADDR declared at the first line of the code in the blueplayer.sh file to the bluetooth address of the device running the media player.

##Usage
* Simply add a reference to the blueplayer.sh file in your home/.bashrc file in order to access media remote control functions from terminal. The supported functions are the following:
  * play
  * pause
  * next
  * previous
* To receive notifications when the track changes, simply run the blueplayer.sh script.

##Compatibility and requirements
I tested in Ubuntu 15.10 and 16.04 with bluez v5.37 installed.
Unfortunately, I can not guarantee its compatibility with other software versions, but it probably works on other versions of Ubuntu and bluez.

If you have any suggestion/feedback, feel free to contact me at gioac96@gmail.com.

Giorgio Acquati
