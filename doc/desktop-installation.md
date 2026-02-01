# Desktop

HamClock may be built for Raspberry Pi, macOS, Ubuntu, FreeBSD, NetBSD, Windows WSL or most any other UNIX-like system supporting the X11 Windows system.

## To install HamClock on a Raspberry Pi follow these steps

These instructions assume your RPi is up and running bullseye or bookworm. If not, first see the FAQ 4, then come back here.

Open a terminal on the target system GUI desktop by clicking on the red Raspberry → Accessories → Terminal. This will give you a command line prompt for the next step.

Download and run the installer script by entering the following commands (use copy/paste to avoid typos):

    cd
    curl -O https://www.clearskyinstitute.com/ham/HamClock/install-hc-rpi
    chmod u+x install-hc-rpi
    ./install-hc-rpi

Answer each question by typing y or n followed by Enter.

If you chose not to install a desktop icon, you can run HamClock from the terminal at any time by typing this command:

    hamclock &

If no errors then that's it! Be sure to read the User Guide to get the most from HamClock. If something did go wrong, try working through the manual steps in the next section.

## To install HamClock on macOS

using macports:

    sudo port install hamclock xorg-server

log out and back in to reinitialize launchd then just type hamclock and it should come right up.

Otherwise you can build from source using the scenic route:

* install XQuartz and Xcode.
* Start Xcode then open More developer tools and install the command line tools. You may also need to run the following command line in Terminal: `xcode-select --install`.
* Now follow the instructions for any UNIX system, below.

If you want a launch icon for the Dock or Desktop, I recommend using the free program Platypus to wrap HamClock into a proper application bundle. The script it will run is just one line to give the full path to the hamclock executable (/opt/local/bin/hamclock if using macports or /usr/local/bin/hamclock otherwise). For an icon use the file hamclock.png found in the ESPHamCLock directory.

## To install HamClock on other UNIX-like systems follow these steps

(works for RPi and macOS too if you prefer the scenic route)

Open a terminal directly on the target system GUI desktop to get a command line prompt.
Run these commands (use copy/paste to avoid typos):

    cd
    rm -fr ESPHamClock
    curl -O <https://www.clearskyinstitute.com/ham/HamClock/ESPHamClock.zip>
    unzip ESPHamClock.zip
    cd ESPHamClock
    make -j 4 hamclock-800x480
    sudo make install

If you get errors:

on Raspberry Pi or other Debian try loading these packages:

    sudo apt-get update
    sudo apt-get -y install curl make g++ libx11-dev libgpiod-dev xdg-utils

on Ubuntu try loading these packages:

    sudo apt install curl make g++ xorg-dev xdg-utils

on FreeBSD try loading these packages:

    sudo pkg install gcc xorg gmake curl

then use gmake instead of make.
on NetBSD go here to install pkgin then load these packages:

    sudo pkgin install gmake curl

then use gmake instead of make.
on RedHat or Fedora try loading these packages:

    sudo yum install gcc-c++ libX11-devel xdg-utils

on Alpine try these commands as root:

    setup-desktop
    apk add g++ libx11-dev curl linux-headers

Now run HamClock by typing:

    hamclock &

Be sure to read the User Guide to get the most from HamClock!

To exit hamclock, click the padlock icon then choose Exit hamclock.

The example make command above will build HamClock with 800x480 pixels. You can also make these sizes:

* hamclock-1600x960
* hamclock-2400xx1440
* hamclock-3200x1920

If you change sizes, add make clean and redo the commands again, for example:

    cd ~/ESPHamClock
    make clean
    make -j 4 hamclock-2400x1440
    sudo make install

If you would like to operate HamClock from any browser on your LAN, see FAQ 14.

If you would like HamClock to fill the screen, set that option on Page 5 of Setup. With this option HamClock will still be the same screen size you built, but it will fill any surrounding gap with black so there is nothing else showing. If you really want HamClock to use all available screen space, see the FAQ 12 about xrandr.

If your system is XDG compliant and you would like a Desktop icon with which to start HamClock, try these commands:

    cd ~/ESPHamClock
    mkdir -p ~/.hamclock
    cp hamclock.png ~/.hamclock
    cp -p hamclock.desktop ~/Desktop

Similarly, if you would like HamClock to start automatically when you boot your system, try these commands:

    cd ~/ESPHamClock
    mkdir -p ~/.config/autostart
    cp hamclock.desktop ~/.config/autostart
