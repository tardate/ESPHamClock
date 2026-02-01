# Answers to Frequently Asked Questions

## 1.  How do I build the ESP8266 software?

See the [ESP8266 Notes](./esp8266-installation.md).

## 2.  How do I build the Desktop software?

See the [Desktop Notes](./desktop-installation.md).

## 3.  How do I uninstall HamClock?

Assuming you only ever installed HamClock according to my instructions in the Desktop tab, you can remove all traces by typing the following two commands in a terminal or ssh session:

    sudo sh -c 'rm -fr ~/.hamclock ~/ESPHamClock* /usr/local/bin/hamclock*'
    rm -fr ~/.hamclock ~/ESPHamClock* ~/.config/autostart/hamclock.desktop ~/Desktop/hamclock.desktop

## 4.  I'm new to Raspberry Pi -- how do I get started?

* If you are absolutely completely new, start at raspberrypi.org.
* If you don't have a Pi yet, I would start with a model 4b with 1 GB RAM. The smaller Pi models such as Zero W will work (see FAQ 56), but the 4b is definitely more responsive. Many places sell Pis or you can see the official list of vendors here. Pis are a little hard to find now but a current list of vendors with stock is here.
* For a display you can use a small touch screen such as the official Pi 7" LCD. Or you can use any HDMI LCD display you might have or buy one such as this one with which you will also need a keyboard, mouse and perhaps a micro HDMI adaptor.
* If you don't already have one, buy a microSD card such as this one.
* Insert the microSD card into your desktop computer. If your computer does not have uSD port, you can try a USB adaptor such as this one.
* Download and install the Raspberry Pi Imager.
* Start the program and burn your microSD card with RPi operating system as follows:
    * click Choose OS
    * select the first choice on top
    * click Choose Storage
    * select the microSD you just inserted
    * click Write
    * wait for it to complete writing and verifying
    * remove the microSD card when it says it is finished
* Insert the microSD card into your RPi
* Connect a keyboard, mouse, ethernet and display to your RPi
* Connect power to the RPi
* After a minute or so you will see the Desktop
* Work through the setup menus
* Start a browser by clicking the red raspberry in the upper left corner then Internet ⇒ Chromium
* Go to my project web page at <https://clearskyinstitute.com/ham/HamClock>
* Start a terminal by clicking the red raspberry again then Accessories ⇒ Terminal
* Follow the instructions on my Desktop tab
* Read the User Guide to get the most from HamClock

## 5.  What can I do if a self-update reports FAIL with a message about SSL certificate?

This error means your system is using a version of openssl (used by curl) that is older than 1.1.1. This occurs because a prominent high level SSL certificate expired on Sept 30 2021 and openssl was updated to use the replacement certificate. You can find your version by opening a terminal command line and typing this command:

        openssl version

To update openssl on an RPi you can try

        sudo apt upgrade openssl

To update on macOS try these possibilities:

If you use macports update openssl as follows:

    sudo port upgrade openssl

(be sure /opt/local/bin is before /usr/bin in your PATH)
or try this direct method (suggested by AL7CR):

* Rename /etc/ssl/cert.pem to something else such as /etc/ssl/cert.pem.org
* Download the latest cacert.pem from <https://curl.se/docs/caextract.html>
* Rename it to cert.pem
* Copy it to /etc/ssl/cert.pem

After the update, repeat the openssl command and you should see version 1.1.1 or larger. If so, repeat your HamClock version update and it should work.

## 6.  HamClock is displaying a big black screen with a cryptic message, what do I do?

It depends on the message.

* permission error
    * The most likely cause is you ran hamclock previously with or without sudo and now you are running it the opposite way. When installed per the Desktop tab directions you should never run hamclock using sudo. It's possible to straighten it out but if you are unfamiliar with linux file system permissions it's probably easiest to just start all over. For that, see FAQ 3 about removing HamClock then go over to the Desktop tab and follow the instructions carefully.
    * Address already in use
    * This means HamClock is unable to use a TCP networking port because another program is already using it. The message will include the particular port number at issue. You must either find this other program and stop it or tell HamClock to use a different port. It can also happen if you run more than one hamclock at the same time; see FAQ 43 for the proper way to do that.
    * To find the other program using the port, suppose the offending port is 8080. Then either of the following commands should provide clues to the other program:

            sudo lsof -Pi :8080
            sudo netstat -tulpn | grep :8080

* sh: 0: illegal option -p
    * This happened in Version 2.58 on RPi if you are running an os version earilier than Buster. It is now fixed so the easiest solution is to remove your current ESPHamClock (see FAQ 3) and install fresh using the instructions in the Desktop tab.
* No memory for satellite
    * This only happens on the ESP because of its very limited amount of RAM. Restart then turn off some data panes that can scroll lists such as Contests, POTA, SOTA and DX Cluster.
* time is running backwards
    * The cause is discussed below but for now just restart. But first, I would appreciate if you would email me the exact message containing the two time values.
    * Trapping this event is new starting in version 3.00 of HamClock. Before then, I had indirect evidence of this from my server logs because when it occurs, HamClock suddenly thinks all content is out of date and floods my server with retries. I had to do something to prevent this so I added the strict time check.
    * The root cause is because NTP uses UDP which does not guarantee packet delivery, order or absense of duplicates. Thus it's possible for a router somewhere to send an old packet resulting in stale NTP time values. Statistics I've collected here from google NTP show one backwards event about every 10^11 packets. That works out to about one bad packet every 2000 days. But since there are well over 2000 HamClocks running the world over, one of them is likely to experience this each day.
    * After I gather more statistics I will try to make HamClock more tolerant to this. For now, thank you for your patience and cooperation.
* Something else?
    * Copy it down exactly and email it to me.

## 7.  Can HamClock run on Windows?

No, you can't run it natively on Windows but you can use it if it is already running somewhere else on your network by using any desktop browser. See FAQ 14 about the hamclock web interface for details.

For another approach, see the User Contrib tab for a suggestion on how to use WSL.

## 8.  Can HamClock run on iPhone or iPad or Android?

Not natively but it does seem to work under UserLand. See User Contrib 16 for more information.

## 9.  How does HamClock compare to Geochron 4k?

I do not have a Geochron 4K but from its literature I can think of the following functions related to ham radio that HamClock offers but Geochron does not:

* customized VOACAP predictions for MUF, TOA and path reliability
* trend plots and predictions for solar flux, solar wind, sunspot, XRay, Kp index and DRAP
* short and long path antenna beam heading and distance to any DX location
* display future satellite rise/set times and next overhead pass (not just global track)
* hamlib and flrig rig and rotator control for chasing DX spots
* display DE time in digital, analog or calendar formats
* list upcoming weekend contests
* azimuthal world maps centered on any location
* local weather, time, grid square, prefix and sun rise/set times at any DX location
* live display of DX Cluster, WSJT-X and JTDX FT8 contacts
* live solar images from Solar Dynamics Observatory and STEREO-A
* live quantitative Lunar data and EME planning tool
* live NCDXF beacon location, time and frequency schedule
* live RSS feeds from popular ham web sites
* live listing of POTA and SOTA activators
* live D layer absorption map
* live auroral map
* live cloud cover map
* live DX Cluster spots of active dx expeditions
* several map projections including Azimuthal, Mercator and Robinson
* Display headings from either true north or magnetic north
* Optional time scales including sidereal, Julian date and UNIX
* stopwatch and station ID count-down timer with optional color LED and switch control
* adjust time forward or back to explore Moon, gray line, satellite orbits etc
* Elecraft KX3 transceiver frequency control from DX Cluster spot
* 2 BME280 sensors for temperature, pressure and humidity real-time and 25 hour trend plots
* Personalized WSPR, PSKReporter and RBN spot maps
* photosensor to adjust display brightness with changes in room lighting
* "On The Air" indicator controlled by GPIO pin from radio
* RESTful API remote control functions from any browser or curl command line
* can display on and be controlled from any web browser
* can become just a simple old fashioned time-and-temperature clock

Conversely, Geochron can do things HamClock can not. These items are certainly interesting but to me they do not seem specifically useful to the typical amateur radio operator:

* air and sea traffic
* pollution, population and pandemic maps

I have nothing against Geochron. If I have misrepresented Geochron in any way, please tell me how and I will correct immediately.

## 10.  How does the DX Cluster feature work?

* In Setup page 2, tap the Cluster? button then set the internet host name and port number for your desired node. A good list is here. HamClock supports DX Spider, AR and CC node types. Not all are active so if the connection fails, try another. If no port is listed, try the usual default of 7300 for Spider and 7373 for AR-Cluster.
* Also on Setup page 2:
    * You may enter a login different from your call, such as WB0OEW-1. It is important to use unique logins for each program you use at the same time as HamClock which are connecting to the same node. If left blank, HamClock will use your call sign.
    * You can set one or more prefixes in the Watch list, separated by blanks or commas. When a spot arrives starting any of these it will be highlighted in the list.
    * You can set several arbitrary cluster commands. Those commands that are set On will be sent one time when HamClock logs into the node. HamClock will store all the commands for you, whether they are On or Off. Use the commands appropriate to the type of node you select. An intro to Spider commands is here and for AR-Cluster here.
    * It is important to understand that cluster commands are saved on the node and remain in effect for the given login name even if you log out and log back in. It is not enough to just not send them to get the opposite effect. For example, suppose you want to reject all spots of US amateurs, you could enter this (spider) command and set it On:

            rej/spot 0 call_dxcc 226

    * Because it is set On HamClock will send this command when it logs in. Now suppose you restart HamClock and just turn this command Off. This tells HamClock to not send this command when it logs in. That's fine, but since the cluster remembers your settings across logins, the filter will still remain in effect! To turn off this filter, you need another command to explicitly clear it, such as

            clear/spot 0

    * Thus, it's a good idea to create pairs of commands, one to engage and one to cancel each filter type.
* While in Setup, go to page 5 and choose the desired scrolling direction. You can also control whether spots are labeled on the map as complete call signs or just the prefix and whether and how the full path is drawn. Note that only the DX side is labeled since it rarely matters who exactly made the spot, just where.
* Once HamClock is up and running, select the DX Cluster data pane in either of the two right panes. The name of the host will be shown in yellow while a connection attempt is in progress, then it will turn green when the connection is established. If the connection fails, it will show an error in red.
* Once connected, just leave it run, new spots will be listed, scrolling when full. Tap on a spot to set HamClock's DX to that location. The tap can also set the frequency of your radio, see the User Guide for details.
* HamClock stores several more spots than those listed; use the Up and Down arrows to scroll backwards and forwards through time. HamClock always adds new spots to the end of the list, but if you have scrolled away HamClock will not automatically scroll back to the beginning to show them. To ensure you will see new spots immediately, just make sure the opposing arrow is not drawn.
* Beware: HamClock stays logged into the cluster node with your call sign as long as the DX Cluster data pane is visible. So do not use this feature if you want to use the unassisted category in a contest -- some judges do check!
* HamClock can also use the DX Cluster pane to communicate with WSJT-X or JTDX. Instead of showing cluster spots, it shows each FT8 station you log. Details for doing this are in the User Guide.
* HamClock enforces a limit of 10 server disconnects per hour. This was implemented at the request of cluster sysops to prevent HamClock repeating connection attempts endlessly do to the following situations:
    * You have multiple software programs connecting to the same cluster using the same login. Clusters reject multiple simultaneous logins from the same callsign. So when HamClock connects with the same call in use elsewhere, the node disconnects, HamClock retries and this repeats continuously. The limit of 10 now prevents this. The solution is to use a unique suffix for each program, such as WB0OEW-1 and WB0OEW-2.
    * You have set some nonsense cluster login, such as all blanks or NOCALL. The nodes also reject these, resulting in the same reconnect looping situation. The solution is to enter a valid call sign, perhaps with a suffix as above.

## 11.  Can I make different sizes other than those in the Makefile?

No, HamClock can only be built these sizes:

* 800x480
* 1600x960
* 2400xx1440
* 3200x1920

The base size of 800x480 was set when HamClock started life back in 2016 on a stand-alone ESP8266 microprocessor with an 800x480 LCD display.

It is not a simple matter to change that original aspect ratio. Each size requires its own custom fonts, graphics symbols, maps and images in order to take proper advantage of the different resolutions. Otherwise, these would be very pixelated if they were just multiples of the base images. Plus, if the ratio changes, the layout would need to be rebalanced. This is why all sizes are multiples of 2 of the base size in order to maintain the same layout proportions.

It is also asked whether the size could be changed dynamically rather that at make time. To do so would be a tremendous amount of work.

All of the images, maps and fonts are stored as pointers that get aliased to memory blocks at compile time. To do this at runtime would mean everything for all sizes would have to be in memory, along with corresponding changes to temporary storage array sizes that come and go and must match. So even the smallest 800x480 would have to carry everything for 1600x960, 2400x1440 and 3200x920 images etc, which would prevent running on the smaller boards such as Raspberry Pis.

There's also the issue of graphics resolution. HamClock draws all its graphics by itself, it uses no libraries. So changing sizes also requires changing resolutions for the Bresenham algorithms, adapting image pixel resolutions, the home-grown techniques for jaggie reductions, and more, on the fly.

Another issue is that hamclock sends requests back to my server for all the real-time images and data. The replies are tailored to match the resolutions of the requesting size. If the request sizes from a given IP were to change dynamically, the backend caching algorithms would break causing increased load on my server. I already have to use a 16 core monster with 8 TB of RAM in order to handle the 10k hamclocks running out there every day. Plus, there are clocks that have been running for several years, so I would also need to maintain the existing serving mechanisms while growing the new set in parallel, further impacting performance. Since I pay for the server out of my own pocket I'm not keen to require a larger server.

Would I architect it this way if I started today? No way! But such contortions are not so rare for a program that has morphed several times over a decade.

## 12.  What is xrandr, or How do I get rid of the full-screen black border?

xrandr is dying an agonizing death, consider using a browser instead, see FAQ 14.

Even though full screen mode uses the entire screen, HamClock still only uses the pixels specified in the make command size, filling the remaining space with black. With the GUI configuration (not fb0) you can try a command line program called xrandr to expand HamClock to fill the screen by changing the effective display resolution to match HamClock.

Xrandr works by changing how the X server maps pixels to the display hardware. It's easy to try and undo if you decide you don't like it.

For example, my display is 1920 x 1080. HamClock can be built for sizes 800x480, 1600x960, 2400xx1440 and 3200x1920. Thus, the largest I can build HamClock that will fit is 1600 x 960. If I run this size with the Full screen option in setup set to Yes, HamClock will still be that size but will fill the surrounding gaps with black. With xrandr one can expand HamClock to fill the screen and eliminate those gaps.

To try it on a Pi, log in from some other computer with ssh (or putty) so we aren't trying to adjust the same screen we are using for commands. Run the following command while HamClock is running in its full screen mode:

        xrandr --output HDMI-1 --scale-from 1600x960 --display :0

That's it, the effect should be immediate but ...

* If xrandr gives an error about bad parameter match, try changing scale-from a little.
* If at any time you want to go back to normal run xrandr again with your original screen size:
* xrandr --output HDMI-1 --scale-from 1920x1080 --display :0
* The xrandr change does not survive logging out or rebooting. To make the change permanent, put (or add if it already exists) the exact xrandr command you liked in the file ~/.xsessionrc followed by &. Thus, using the same example as above, the file should contain:

        xrandr --output HDMI-1 --scale-from 1600x960 --display :0 &

On RPi version bookworm things are different because the default window system has become Wayland. You can either use raspi-config to change back to X11 so the above will work, or you can use Wayland's alternative command called wlr-randr as follows:

* ssh into the pi to which the display is connected.
* type in the command:
* export WAYLAND_DISPLAY=wayland-1
* run wlr-randr with no arguments to get a list of supported sizes.
* look through the list and find the smallest size that is larger than your hamclock. Also note the name of the display, as reported on the first line.
* run the command again but this time adding more arguments for your chosen values. For example:
* wlr-randr --output HDMI-A-1 --mode 1680x1050
* The effect will only last until you log out. To make the change permanent when running wayfire, edit the file ~/.config/wayfire.ini and add two lines at the bottom; again for the same example:

        [output]
        mode = 1680x1050

xrandr works on macOS too with XQuartz but it only allows choosing from a fixed set of sizes. So you can still reduce the border but you may not be able to eliminate it altogether. The general idea is to use the following procedure, again adjust sizes to fit your situation:

* Run xrandr with no arguments for a list of available sizes; pick one at or slightly larger than your hamclock.
* Start HamClock and enter Setup.
* Go to Page 5, click Full Screen to Yes; now just leave it there for the moment and go to the next step.
* In another terminal run xrandr --size 1600x1200. You'll see the hamclock size jump.
* Now back in HamClock, click Done and HamClock should now occupy almost the entire screen.
* To get your screen back to normal, click HamClock's padlock then choose Exit HamClock.
* If you get really stuck in full-screen mode, type Option-Command-A to force XQuartz back to normal.

## 13.  Can you bring back the old VOACAP data pane? I liked it much better

In a word, no. I have two reasons.

One is the previous version provided precision far beyond what is real. The VOACAP model is based on monthly averages, so several tens of percentage point changes can easily occur due to solar flares, geomagnetic disturbances and other effects that happen very rapidly. So although the model does generate percentage values, they don't really have as much meaning as the precision implies. I think of the VOACAP model as similar to climate. As the saying goes "climate is what you expect, weather is what you get".

The second reason is I think seeing the daily trends adds greatly to the value of the display. For example, at a glance you can tell whether conditions will improve or get worse in the next few hours, or quickly pick a time of day that offers the best chances to contact a given location. These trends and planning capabilities were not possible when only the present hour values were shown.

Having said this, I will allow that it was nice to see just the current conditions at a glance. This is why I added a small marker below the new graph to show the current time. This way, you can just scan your eye up that column to see basically the same information as presented previously, with precision that represents reality just as well. Granted they are not numbers, but the color choices remain the same as before: red < 33%, yellow < 66% and green above 66%, with one change that I now make < 10% black.

Give it more time and perhaps you will come to like the new graph as much as I do.

## 14.  Does HamClock have a web interface?

If you are looking for the RESTful API command interface, see FAQ 42.

Yes. Use a browser to load the page live.html on port 8081 from the host running hamclock. For example, if HamClock reports its local IP as 192.168.7.101, then enter this URL to run it from your browser:

        http://192.168.7.101:8081/live.html

Some notes:

* HamClock will be centered if smaller than the browser window, or shrunk to fit if the browser window is smaller. If the image looks chunky, build HamClock at a larger resolution.
* Keyboard and mouse input work if you first click on the HamClock window to give it focus.
* Multiple simultaneous browser connections will share the same instance, they all have control and all will stay in sync with each other.
* Setup page 5 Full screen web? is supported but won't engage until the user makes at least one mouse tap. This is not a bug in HamClock, this is because of a web standard requirement to prevent malicious software from taking over the screen without explicit user action to do so.
* To reset a browser session for any reason, refresh the page. This will undo the full screen option until you click HamClock again (see previous).
* Screen blanking and timed on/off are not supported -- use your browser host's facility.
* If using full screen, the options to shutdown, restart etc apply to the computer running HamClock, not the computer displaying it in a browser.
* If bandwidth is a concern, the lowest bandwidth occurs when HamClock is made 800x480 and the map Night option is off.
* If unintended or malicious input is a concern, connect instead to port 8082 which provides a read-only interface or add passwords with -p per FAQ 52.

Why would you use this?

* It's an easier alternative to VNC or remote X servers.
* It's an easier way to accomplish full screen compared to using xrandr.
* It allows displaying one HamClock on multiple monitors simultaneously for, say, a contest group.
* To run multiple independent instances from the same URL see the User Contrib 12.
* You can see and control HamClock with your phone (if you dare).
* It's the easiest way to run HamClock on a headless Pi. To try this, make one of the hamclock-web-XXX versions and run as follows: (type make help for a complete list)

        cd ~/ESPHamClock
        make -j 4 hamclock-web-1600x960
        sudo make install
        hamclock &

* You won't see anything on your screen now, but browse to the host running HamClock as described above and voilà! you will find a live HamClock.

To start this automatically on each boot, run crontab -e then add the following as the last line:

    @reboot /usr/local/bin/hamclock

Can I change the connection port number?

Yes, by using the -w command line option. For example, to change to port 7000, run hamclock as follows:

    hamclock -w 7000

Can I connect with https?

Not directly, HamClock only supports http connections. But if you have administrative access to a web site running apache, you can set up a reverse https proxy as follows:

* You must use HamClock version 2.96 or newer.
* If you don't already have a TLS certificate, visit Let's Encrypt to install one at no charge. Without a proper cert you will not be able to run https.
* Find the apache configuration file containing the section for your VirtualHost *:443. On Ubuntu, it's somewhere in /etc/apache2.
* Within this section insert the following:

        # allow specific https access to http hamclock
        ProxyPass  /hamclock-live/live.html   http://127.0.0.1:8081/live.html
        ProxyPass  /hamclock-live/favicon.ico http://127.0.0.1:8081/favicon.ico
        ProxyPass  /hamclock-live/live-ws     ws://127.0.0.1:8081/live-ws

* Use port 8082 for read-only access.
* Make sure a few modules are loaded:

        a2enmod proxy proxy_wstunnel proxy_http

* Restart apache, typically with apachectl graceful.
* Build and run hamclock on the same machine running apache.
* Now use any browser and surf to your new HamClock web site with the following URL:

        https://<your_web_site>/hamclock-live/live.html

Cheers, and thanks for using HamClock.

## 15.  Why do I get an error when displaying a satellite or it disappears after a while?

Probably because your time is off. If the button below and to the right of your call sign says OFF then tap it so it says UTC and try again.

The error occurs because sat elements are only good for a few days so if the clock's time has been adjusted outside the valid range you'll get an error message. Time can be adjusted away from UTC if you click any of the time fields. That can be handy to intentionally move time forward or backwards to explore gray line, VOACAP predictions etc. See page 7 of the User Guide for more details.

## 16.  Why do I have two HamClocks with identical settings showing slightly different VOACAP maps?

Because they are showing maps for two adjacent hours.

Ideally all Clocks would update at the top of the hour. But with several thousand Clocks running the world over that would overwhelm the backend server. In order to spread out server hits, Clocks intentionally randomize their VOACAP updates throughout each hour. This means the map shown by any given Clock might be up to one hour late.

So in your case, one clock is showing a map for the current hour, and the other is still showing from the previous hour. When the Clock that happens to be updating later updates, it will then show the same map until the cycle repeats next hour.

## 17.  Why is my grid square wrong?

It's probably not wrong but I can think of two possibilities why you might think so:

You are near a grid boundary and the HamClock display is misleading because of rounding.
For example, suppose you set your location to 35.1N 110.1W which is in grid DM45. HamClock will display this in the main DE pane as 35N 110W grid DM45. But taken at face value 35N 110W is in grid DM55 so the grid appears to be wrong because the location is rounded for display. When in doubt, open the lat/long dialog to review the values as they are stored internally.

Note that displaying more precision would not eliminate this issue entirely, it can only reduce the region where this occurs.

There are two different algorithms for exactly where a grid square is located.
Some programs use the center of a grid for their position, others use the SW corner. HamClock uses the corner because that is the historical technique described in [this paper](https://www.clearskyinstitute.com/ham/HamClock/QSTGridSquares.pdf) published in January 1989 QST. My personal favorite web site that uses this technique is [here](https://www.karhukoti.com/maidenhead-grid-square-locator). But other popular web sites use the center, such as [this one](https://www.qrz.com/gridmapper) on QRZ.com. So it depends which you consider correct.

If you still feel HamClock is in error, please send me the exact details.

## 18.  What is the HamClock diagnostic output?

It is additional detailed status and diagnostic information HamClock writes to the file $HOME/.hamclock/diagnostic-log.txt. It is not intended for general consumption but can be helpful for troubleshooting.

The previous 3 logs are also stored in a rolling set with the following names:

        diagnostic-log-0.txt
        diagnostic-log-1.txt
        diagnostic-log-2.txt

Sometimes it can be helpful to watch the file in real time which you can do with the following command; type Control-C to quit.

        tail -f $HOME/.hamclock/diagnostic-log.txt

When asking for assistance, you may be asked to upload these files to my server for analysis. To do so, tap the padlock icon then select Post diagnostics.

The amount of information added to the diagnostic file can be changed while HamClock is running using the RESTful command set_debug. All the current levels are included in the reply to get_sys.txt. Larger level values will log more diagnostic information.

For example, the following command will set the debug level for the ADIF subsystem to 1:

        curl '<hamclock-ip>:8080/set_debug?name=ADIF&level;=1'

## 19.  What is sudo and set-uid and why should I use them with HamClock, or not?

Sudo stands for "super-user do". In UNIX, the super user refers to extra privileges bestowed upon the root user. Rather than actually logging out and logging back in as user root to gain these privileges, this command arranges for you to have these greater privileges just long enough to run the command that follows on the same line. After that command completes, you are again restricted back to the normal privileges of your current user login.

But using sudo comes at a price.

Depending on /etc/sudoers it may require entering a password each time.
It temporarily changes the HOME directory to /root. HamClock creates and uses a working directory named .hamclock (note the leading dot) in the HOME directory. HOME for the normal pi user is /home/pi. Thus, if you run HamClock without sudo it uses /home/pi/.hamclock but if you run it with sudo it uses /root/.hamclock and files therein are not accessible to the normal pi user. This duality can cause much confusion.
sudo temporarly imposes a new set of minimal, more secure, environment variables. For example HOME becomes /root, PATH becomes just /bin:/usr/bin and DISPLAY is removed entirely. These are all at odds with HamClock.
A much better way is to use set-uid. This refers to an automatic mechanism engaged by setting the mode of a program file in such a way that when the process runs, it has the same permissions as the owner of the file. Normally, the process has the permissions of the user running the file. Thus by making the program file owned by root, it has super-user privileges no matter what user runs it. Using this mechanism for HamClock allows it to have super-user privileges without using sudo. Unlike sudo, using set-uid does not change anything else, so HamClock will still use your /home/pi/.hamclock directory for its support files as expected.

The reason to escalate privileges with either of these methods in the first place is that HamClock requires super-user privileges to perform certain external IO and protected file system operations. It is possible in some configrations for someone with sufficient UNIX administrative knowledge to make adjustments so HamClock can run without super-user privileges, but this is beyond what most users want to deal with. So in the interest of providing the simplest and most enjoyable experience possible for the majority of users, the install instructions use set-uid root.

For those still interested in eliminating the need for root privileges, the following commands may help for RPi. They perform the following functions:

* add user pi to various groups to allow necessary IO access
* remove the set-uid bit from the executable file
* change the group ownership of /usr/local/bin to user pi
* allow any user in group pi (specifically user pi) to modify /usr/local/bin

        sudo usermod --append --groups video,input,gpio,i2c pi
        sudo chmod u-s /usr/local/bin/hamclock
        sudo chgrp pi /usr/local/bin
        sudo chmod g+w /usr/local/bin

The last two steps are required so automatic updates may write a new version of the executable file in /usr/local/bin.

After executing these commands, subsequent instances of hamclock will no longer run as root but should be able to perform most functions. But note if you perform sudo make install again in the future this will set the set-uid bit again so remember to perform command 2 again.

## 20.  Is it possible to change the RSS feeds?

No. RSS feed formats are surprisingly inconsistent so I perform all the heavy lifting on my server and only send the plain titles back to HamClock. Plus, most now use https which uses too much memory for the little ESP processor.

That said, if you have a feed in mind that is of general interest to the global ham community, send me your suggestion and I will consider adding it to the server processing.

You might also consider setting your own titles locally using the set_rss web command (see FAQ 14) or run the contributed script hcrss.pl (see the User Contrib tab).

## 21.  Is it possible to speed up the data pane rotation?

Yes. See Setup page 5 for several speed choices.

## 22.  Occasionally I see "WX too fast" or similar -- What does that mean?

It means either my connection to Open Weather Map is overloaded or your clock is making queries too rapidly.

In order to stay within the usage limits of my OWM subscription, my backend server will deny all HamClock weather queries if they arrive faster than 200 per minute.

My server also limits the request rate from any one public IP. Note if you have more than one HamClock at your shack, they all count as one for this limit because they each report the same public IP address.

## 23.  Why is the data pane choice menu not working as I expect?

If you are asking why you can not turn off a specific choice:

* Each data pane must have at least one choice enabled at all times. To enforce this policy, you are not allowed to turn off the only remaining choice. The correct procedure is to first select another choice, then turn off the one you no longer want.

If you are asking why a specific choice is not listed:

* A given choice may only be assigned to one data pane at a time. To enforce this policy, the menus automatically remove choices that are already assigned to other panes. The correct procedure to move a choice to a different pane is to first turn it off in its current pane, then select it in the desired pane.
* Note also that the DX Cluster data pane is not allowed to be in the left position across the top.

## 24.  Is it possible to change the set of satellites?

You can not change the built-in set but you can add to them.

Create a file named ~/.hamclock/user-esats.txt (or where ever you set -d). In the file put three lines per satellite, one for the name followed by 2 lines for its TLE. Blank lines and those beginning with # are ignored.

HamClock operation remains unchanged; the satellites in this file will automatically be included at the beginning of the satellite selection table.

You are responsible for keeping the TLEs up to date. HamClock will refuse to use any that are older than the maximum age set in Setup.

Again, you can not change the core set of built-in satellites that HamClock uses. But if you feel a satellite would be interesting to the larger amateur community, please let me know and I will consider adding it to the built-in list. <ecdowney@clearskyinstitute.com>.

## 25.  How are the background maps managed?

As of Version 2.52, the background map images are downloaded and stored as local files as needed. In previous versions they were embedded within the executable image and were thus immutable and limited by size of non-volatile memory.

This meant the ESP HamClocks could only ever support one map style, and even that was only at half the available screen resolution. ESP HamClocks now use the extended FLASH file system to store the map images at full resolution. The improved resolution is especially apparent in the night portion of the Terrain style map. Unfortunately, more pixels and slower FLASH access means the display update rate on the ESP is about 30% slower now but the added flexibility and visual results seem worth it.

The UNIX versions of HamClock store their map files in ~/.hamclock so the number of files is limied only by available disk space.

If you run HamClock without a network connection, you will be limited to map styles already downloaded.

The maps are stored in .bmp format, version 4, using 16 bit RG565 pixels. There are separate files for day and night for each map style. HamClock uses these to render the day and night regions and blends them in a 12° band to simulate civil twilight.

## 26.  How does the self-update facility work?

When asked to update itself, HamClock checks the support server if there is a newer version available. If so, for the ESP systems this is a binary file that is downloaded directly into FLASH and that's all there is to it.

But for the Desktop UNIX systems, this is a zip file containing the source code that requires many more steps:

* the zip is downloaded into a unique directory within /tmp
* it is exploded with unzip which creates the source tree
* make is run within the source tree, using the same target that was used to build the currently running program
* the resulting program file effectly overwrites the currently running program file.

These steps present two challenges: how to find the full path of the program file to a running program and how to update its program file while it is still running.

To find the program file full path, HamClock first checks the argv[0] path given when it was executed, digging through symlinks if necessary to find the real program file. If this is already a full path, indicated by beginning with a slash (/), we are done. If not, then a test is made whether a file with that name exists with respect to the current working directory of HamClock. If so, we are done. If it still is not found, then the argv[0] name is checked for in each of the directories named in the PATH environment variable. If still not found, the update fails.

To update the program file, we have to deal with the fact that it is not possible on UNIX to modify the program file of a running program (even as root). So instead, HamClock does it indirectly by first removing the program file then copying in the new one created by make so it has the same name. To remove the current program file, HamClock requires write permission on its containing directory because removing a file actually just edits it out of its containing directory. If HamClock does not have this permission, the update fails. Copying in the new file then edits the same name back into the same directory, so it looks like it was overwritten when actually it was deleted and added again. Meanwhile, HamClock can continue to run because a deleted file still actually exists in memory until the last process with it open either closes it or exits, even if it is not named by any directory.

## 27.  How do I connect the Bosch BME280 environment sensor to RPi?

You have two choices. One is to wire it to the 40 pin header as described below. The other is to use a USB-I2C bridge as described in FAQ 45.

On the Raspberry Pi running linux, proceed as follows:

* connect the sensor to the RPi using the 40 pin connector as follows:

| BME label | RPi Header pin |
|-----------|----------------|
| Vin       | 1              |
| SDI       | 3              |
| SCK       | 5              |
| GND       | 9              |

* install i2c-tools:

        sudo apt-get install i2c-tools

* run sudo raspi-config and set the following options:

        Interface Options ⇒ I2C: enabled

* Check the Bosch is connected correctly with these tests:

        sudo i2cdetect -y 1

* you should see 77 in lower right corner of matrix; then

        sudo i2cdump -y 1 0x77 b

* you should see a matrix of different numbers, not just all XX
* Start HamClock. Enter Setup, go to Page 4, tap GPIO so it says Active. Also set the i2c file, probably /dev/i2c-1 but see the User Guide page 16 for more details. For now leave the delta values set to zero. Click Done.
* After HamClock is up and running again, tap any data pane and select one of the ENV plots.
* If you have some means of measuring temperature and pressure independent of the BME280, note the errors, restart HamClock and enter the corrections in page 4 of Setup.
* Finally, you may add a second BME280 as shown in the schematic. Note that each has a different I2C bus address depending on whether SDO is grounded.

On a Raspberry Pi running FreeBSD 14.0-RELEASE, proceed as follows:

* Connect the hardware the same as above
* Edit /boot/msdos/config.txt to add the following line to the [all] section then reboot:

        gpio=2,3=a0

* Test by running sudo i2c -s which should immediately report the device address(es).

How long can the cable be?

* I have used a direct connection of ten feet without any problem. I have also successfully used 100 feet of Cat 5 using a pair of these [extenders from Sparkfun](https://www.sparkfun.com/products/16988).

## 28.  What if my BME280 always reads 100% humidity?

This may mean your device has become saturated. According to the data sheet page 46, you can try reconditioning the device by baking it at 120 C for 2 hours, then letting it slowly cool to 25 C over 24 hours. If this doesn't help then your device may be broken.

## 29.  How do I exit HamClock?

Click the padlock then select Exit HamClock.

## 30.  What happened to fb0?

Nothing, it's still supported for legacy users, but now that the GUI version can display full screen it is no longer recommended for new installations.

For those new to HamClock who may not know about fb0, it was an early attempt to provide a full screen experience by turning off the GUI and accessing the RPi video frame buffer directly. This was accessed through the special file /dev/fb0, and hence the name. This allowed HamClock to fullfill its charter purpose on RPi of being a stand-alone appliance for ham radio information. Although successful, it required a lot of special programming and could be a challenge for users to install. It is now replaced by using FreeDesktop.org atoms to accomplish the same full screen functionality with the normal desktop.

## 31.  Must I use /usr/local/bin for the executable?

No. To build hamclock and put it in, say, /usr/bin, use the following steps:

        cd ESPHamClock
        make -j 4 hamclock-1600x960
        sudo mv hamclock-1600x960 /usr/bin/hamclock
        sudo chown root /usr/bin/hamclock
        sudo chmod u+s /usr/bin/hamclock

## 32.  Why does my screen go blank after a short while or not blank at all?

Screen blanking control is a complex dance between the host and HamClock, and the music keeps changing.

Let's check the host first.

* On systems running RPi Debian Bullseye start a terminal
    * run sudo raspi-config then
        * Go to Display Options ⇒ Screen Blanking ⇒ Enable
        * Go to Advanced Options ⇒ Wayland ⇒ Disable
        * select Finish (don't reboot yet)
    * HamClock and xscreensaver do not mix. To make sure you don't have it installed, run these commands:
        * sudo apt remove xscreensaver
        * sudo apt autoremove
    * Edit /etc/X11/xorg.conf.d/10-blanking.conf and make sure the line for DPMS shows Enable.
    * reboot
    * Log in, open a terminal and type xset dpms force off. If the screen goes blank then HamClock should be able to blank the screen as well. Click your mouse or type any key to get the display back on.
* On systems running Bookworm, or any system running Wayland, the means to control screen blanking is not yet stable which means the Idle timer and On/Off controls may not work at all. At the very least, on RPi make sure to use the HDMI plug nearest the power port. Give it a try without changing anything first; you might be lucky.
* You may find HamClock can turn the monitor off but it comes right back on again. If this happens edit /boot/firmware/cmdline.txt and add vc4.force_hotplug=1 to the end of the existing line (don't create a new line), then reboot.
* If still no luck, your best bet is to turn off Wayland as follows:
    * run sudo raspi-config then
        * Go to Display Options ⇒ Screen Blanking ⇒ Disable
        * Go to Advanced Options ⇒ Wayland ⇒ Disable
        * select Finish (don't reboot yet)
    * Edit /etc/X11/xorg.conf.d/10-blanking.conf and make sure the line for DPMS shows Enable.
    * Click the Raspberry in the upper left corner to log out and log back in
    * Open a terminal and type xset dpms force off. If the screen goes blank then HamClock should be able to blank the screen as well. Click your mouse or type any key to get the display back on.
* It could also be the monitor itself. Activate the monitor's own control menus and look for an option related to automatically setting the input. Turning this off and setting HDMI directly can sometimes help.

As for HamClock itself, it will only blank the screen if:

* Full Screen mode is Yes in Setup page 5
* it was not built to be web-only
* it is displaying on the same system on which it is running

If these criteria are not met then HamClock will not try to blank the screen, thus any blanking that does occur must be caused by the host system, not HamClock.

Follows are the HamClock settings that control when it will blank the screen:

* Check the Idle time in the upper right corner. You may have to click the title region to change options to find the value. Click just above or below the Idle number to increase or decrease by 5 minutes. Set to 0 to display idle blanking.
* Check the Off and On (or Dim) times in the same menu. Change them the same way; set the times equal to disable blanking. These can also be set on a daily basis in Setup page 7.

## 33.  Why is the CPU usage so high on the Pi and other UNIX platforms?

This is a consequence of HamClock being originally written for the ESP8266 embedded processor. I wrote a porting layer that allows me to use the same application code on the Pi. This saves me a lot of effort but since the ESP8266 code is fundamentally an infinite loop, the result is the UNIX program runs all the time also.

It's not usually a big deal in practice but if it bothers you, use the hamclock -t command line argument to set the desired CPU percentage. For example, to limit cpu usage to about 50%, run hamclock as follows:

        hamclock -t 50

Note that lower limits will result in more sluggish performance.

Unfortunately, this does not work when HamClock is displaying to a web browser. In that case we suggest using the linux program cpulimit. For example, to limit hamclock to 50% start it with the following command:

        cpulimit -l 50 hamclock

If you get a message that cpulimit is not found, you can install it:

        sudo apt install cpulimit

There is a similar program available for macOS called cputhrottle available from macports or homebrew. It can not start a program, it can only be used to control a program that is already running. So start hamclock, find the PID, then run as follows:

        sudo cputhrottle PID 50

## 34.  What are rigctld and rotctld?

Rigctld is hamlib's rig control daemon, and rotctld is the rotator control daemon. They provide a device independent network protocol to control several brands of radios and single and dual axis antenna rotators without having to know their individual commands. On RPi you can install them with sudo apt install hamlib.

HamClock can create a network connection to these programs for automatic control of any radio or rotator* supported by hamlib. To get a list of all supported equipment run the programs with -l, such as rigctld -l. You must get these hamlib programs working with your equipment before you can use them with HamClock.

For practice, you can run either program in simulation mode by specifying model one, such as rotctld -m 1. Then enter the program's host and port number in HamClock's Setup, page 3. The rotator simulator is particularly fun. Start the simulator, then select the Rotator pane and get acquainted with the controls before connecting to your real rotator. There is no pane dedicated to rig control, it is only used to automatically set the radio frequency of a DX Cluster spot.

Do not confuse rigctld (or rotctld) with another hamlib program named rigctl (or rotctl). This program, without the trailing d, provides direct radio (or rotator) control using the command line, not a network connection. Both the command line and the network program use the same control libraries under the hood, so if one works the other will also. It can be a good idea to use rigctl (or rotctl) for initial testing, then once that works, change to rigctld (or rotctld) using the same -m model selector to allow network control from HamClock.

* Note as a special case, although the Yaesu G5500 rotator is not supported by hamlib because it has no serial or networked computer interface, there is a project that provides a drop-in replacement for rotctld for the G5500 here .

## 35.  What is flrig?

[flrig](http://www.w1hkj.com/files/flrig/flrig-help.pdf) is W1HKJ's program to provide network control of many ham radio transceivers. It historically provided rig control to fldigi but works very well on its own. Unlike the hamlib tools, flrig includes its own GUI so many consider it easier to use.

You can download packages for several platforms here or on RPi you can install it with the command sudo apt install flrig. Once installed, just type flrig and go to Config → Setup → Transceiver to prepare for your radio.

A handy tip for troubleshooting the connection between HamClock and flrig is to run flrig in stand-alone mode without needing a radio. Install it on the same computer running HamClock and configure Setup page 3 for flrig Yes and set host to localhost and port to 12345. Now let HamClock start and run the following command in a terminal:

        flrig --test

HamClock should connect. Click the PTT button on flrig and HamClock should display the PTT message.

## 36.  Can HamClock run without a network connection?

It will run but you won't see much.

HamClock connects to clearskyinstitute.com for all the data plots, real-time images and maps and to various NTP servers for time. That just leaves the moon, NCDXF beacons, and BME environment data that is sourced locally.

You could get time without a net connection by using a GPS antenna and running gpsd.

On the other hand if you have a slow network connection, see FAQ 46.

## 37.  Why does HamClock report K index and not A?

Three reasons:

* K is more timely. The K index is reported every three hours while the A index is only updated once per day.
* NOAA provides a 2-day forcast for K index, which is not provided for A index.
* A can be computed from K if desired. Details can be found in the [WikiPedia article](https://en.wikipedia.org/wiki/K-index).

## 38.  Why does HamClock report a different space weather value compared to XYZ?

It could be a different source or different timing.

There are multiple primary resources for some statistics so it depends on which you are comparing with. For example, the sun spot numbers are determined and reported independently by [NOAA](https://services.swpc.noaa.gov/text/daily-solar-indices.txt) in the US and [SILSO](https://www.sidc.be/silso/eisninfo) in Belgium.

It can also be due to timing. The various primary data sources publish at different times during the day and they are not always exactly on time. The secondary data consumers also have their own schedule of picking up the values which can also vary. For example, even WWV sources are not always in sync. Typically their Sun Spot Number [json](https://services.swpc.noaa.gov/json/solar-cycle/swpc_observed_ssn.json) feed is several hours ahead of their [text](https://services.swpc.noaa.gov/text/daily-solar-indices.txt) feed. Another example are their Kp numbers from [here](https://services.swpc.noaa.gov/text/wwv.txt) and [here](https://services.swpc.noaa.gov/text/daily-geomagnetic-indices.txt) are often out of sync by half an hour or more.

## 39.  What are JD, MJD, LST, Solar and UNIX times?

These are time scales useful in various applications other than ham radio. They are included with HamClock because of its general role as a time keeping device.

* JD is Julian Date. It is a steady continuous time scale for marking astronomical phenomenon spanning millennia. The value starts at noon Jan 1 4713 BC and increments by one each day thereafter. The Wikipedia entry is [here](https://en.wikipedia.org/wiki/Julian_day).
* MJD is Modified Julian Date. It is the same as JD but rebased to midnight Nov 17, 1858, by subtracting 2400000.5. This produces a more manageable number and starts each day at the more familiar midnight.
* LST is Local Sidereal Time. This is the value of Right Ascension currently passing through the local meridian. It is used by astronomers to quickly determine what portion of the celestial sphere is currently visible from a given location. One day on this scale is about 23:56 so it slowly advances during the year compared to civil time. The Wikipedia entry is [here](https://en.wikipedia.org/wiki/Sidereal_time).
* AST is Apparent Solar Time. It is the local time referenced from the actual location of the sun, not the mean location used by civil time systems. The difference between these two is known as the Equation of Time. The Wikipedia entry is [here](https://en.wikipedia.org/wiki/Solar_time).
* Unix time is the number of seconds since Jan 1 1970 UTC, not including leap seconds. It was created as a simple means of determining absolute time on early UNIX operating systems. It remains in commom use today because of its simplicity and convenience. The Wikipedia entry is [here](https://en.wikipedia.org/wiki/Unix_time).
* Day of Year is often used for research data, time stations, and in military planning tools. For example see its usage at NSIDC, CHU and the Wikipedia entry [here](https://en.wikipedia.org/wiki/Calendar_date#Day_and_year_only).

## 40.  Why isn't the Idle timeout and/or the On/Off timers working?

HamClock only supports the Idle timeout and On/Off timers in the following situations:

* HamClock is running on the ESP8266.
* The display is connected to a Pi using the DSI ribbon connector or the first HDMI connector.
* The Setup setting for Full screen is Yes.
* HamClock on Pi must be using xorg, screen blanking enabled and no screen saver. To check, run sudo raspi-config then
* Advanced Options ⇒ Wayland ⇒ disabled.
* Display ⇒ Screen blanking ⇒ enabled.
* Then also run sudo apt remove xscreensaver and reboot.

## 41.  Can HamClock run on the Raspberry Pi Pico?

Maybe, but I haven't been excited enough to try for several reasons:

* There is no HDMI video so the only display option would be the same SPI LCD used on the ESP8266 version. This glacial interface is the main reason it takes 30-60 seconds to render a single map view.
* The Pico clock speed is only 133 MHz, even slower than the ESP8266 160.
* The small amount of FLASH would not support OTA updates.

But if I were to try, I'd start with this port of the Arduino ecosystem. Note this path would mimic the ESP8266 HamClock, not the RPi version. I'm not aware of any path to achieve the latter.

## 42.  Can HamClock be controlled via a RESTful API interface?

See [api](./api.md)

## 43.  Can I run more than one instance of HamClock at the same time?

Yes but you must arrange that they each use different ports and working directories so they do not interfere with each other. Do this using these command line switches when you start each hamclock:

* -e sets a different REST API port
* -w sets a different web port
* -r sets a different read-only web port
* -d sets a different working directory

For example, to run hamclock using port 9080 for the RESTful API, 9081 for the web interface, no RO web and ~/.hamclock2 for the working directory, start hamlock as follows:

    hamclock -e 9080 -w 9081 -r -1 -d ~/.hamclock2

If you don't need one or more of the networking options, specify port -1 to turn it one off completely.

Type hamclock -help for a full list of switches and their respective default values.

## 44.  Can you make an option that shows the map full size?

In theory, yes, but given the current internal software architecture this would be very difficult.

A key difficulty is that HamClock has no menu bar. This means there would be no way to control features that currently use the surrounding panes which, when you think about it, is almost everything. And adding a menu bar would require changing the internal structure of the program so completely it might as well become a separate program.

Another challenge would be the need for yet another set of map resolutions. This means all the various map styles (MUF, Auroras, Weather, etc etc) would all need to be generated at the new resolutions for each of the four basic build sizes. Generating the maps on demand is already the single highest load on my backend server, so adding more sizes would further increase this load.

So again, yes it's possible because HamClock is afterall "just" software, but for now it's well beyond my available resources.

## 45.  Can I use a USB-I2C bridge to access I2C peripherals via USB on my linux system?

Yes. HamClock supports two choices: the generic CH341T available from several places online and both the full and mini bridges from i2cdriver.com.

* The i2cdriver bridge is by far the easier of the two to use.
    * Plug the bridge into a USB socket and connect the BME280 or other I2C devices supported by HamClock to the bridge.
    * In a terminal, type ls /dev/cu.usbserial*. Look for a new entry that appears only when the bridge is installed.
    * Start HamClock and go to Setup page 4. Enter the full path in the I2C field.
    * Click Done and let HamClock finish booting.
* The CH341T is more work.
    * Download the linux driver from <https://github.com/gschorcht/i2c-ch341-usb>. You need this because even though standard linux already includes a CH341 driver, it only supports the tty capability of the chip, not the I2C.
    * Edit i2c-ch341-usb.c line 660 from

            ch341_dev->irq_descs[i] = irq_to_desc(ch341_dev->irq_base + i);

        to

            ch341_dev->irq_descs[i] = irq_data_to_desc(irq_get_irq_data(ch341_dev->irq_base + i));

    * Now follow the build and install instructions on the github site.
    * Run lsmod and check that i2c_ch341_usb module is installed.
    * Attach your BME280 to the CH341 and plug it into a USB port. I find that using a USB 3 port is much more reliable than a USB 2 port.
    * Run ls /dev and confirm there is a node of the form i2c-N, where N is some number.
    * Run sudo i2cdetect -y N and confirm it shows the I2C address of your BME280, either 77 or 76.
    * Start HamClock and go to Setup page 4. Turn on the I2C field and enter the full path you found above.
    * Click Done and let HamClock finish booting.

The devices function the same as if connected via the native I2C bus, although substantially slower.

Note the native RPi I2C header pins and these USB bridges can not work at the same time.

## 46.  Why does the time stall occasionally?

It is because HamClock is only a single thread of execution so it can only do one thing at a time. Thus, if the network connection is slow everything hangs during file downloads and it can't update the time digits. HamClock tries to reduce this effect by reading in fairly small chunks and updating the time after each chunk completes, but it can still look jerky.

Note the stalling does not affect the accuracy of the internal time keeping because that uses a hardware interrupt, so time proceeds apace regardless of the display.

## 47.  How accurate is HamClock weather data?

The accuracy of the reports depends on several factors.

* The data plan I have with [Open Weather Map](https://openweathermap.org/) provides updates at least every two hours and uses a grid spacing of about ten miles. They do offer plans that provide much shorter delays and smaller grids but I am not willing to pay for them just for HamClock.
* Some of their data comes from models, not actual measurements. This allows them to appear to offer seamless global coverage even in areas that clearly could not have any measuring capabilities, but at the risk of modeling errors.
* HamClock queries for weather using the latitude and longitude given for DE. So the more accurate you specify your location, the better will be the results.

## 48.  Can I copy a configuration to another computer?

Yes, but first a little background.

Each instance of HamClock needs its own working directory for supporting files. By default this is $HOME/.hamclock (note the leading dot). One file therein is called eeprom which contains all the configuration settings. This file is used a lot at runtime so don't change it while hamclock is running.

So, to copy a hamclock configuration from computer A to B:

* create or use an existing directory $HOME/.hamclock on B
* copy the file eeprom from A to B in said directory

You don't have to copy any of the other files in the directory, they take care of themselves automatically.

Having said that, if you have saved multiple configurations, you might also want to copy the entire directory $HOME/.hamclock/configurations

If you would like to keep multiple independent HamClock instances on the same computer, use the command line option -d to specify an alternate working directory for each. Hamclock will create the specified directory if it doesn't already exist. So for example, to use a separate working directory for someone with a call W9ABC, they could run hamclock like this:

    hamclock -d $HOME/.hamclock-w9abc

You can even run several hamclocks at the same time on the same machine, see FAQ 43 and User Contrib item 12.

## 49.  Can I control HamClock with just a keyboard (no mouse)?

Almost on the native GUI interface, definitely not on ESP8266 or the web browser interface.

The reason for "almost" is that the HamClock window must have what's called the "focus" in order for it to receive any keyboard events, and usually the only way to do that is to click the mouse once inside the HamClock window! The only way around this catch I know of is that most window managers have options such as "focus follows mouse" or "focus on new windows" which may help if you can find them.

But once HamClock has the focus then yes indeed, it can be completely controlled from the keyboard as follows:

* hjkl or arrow keys move the red arrow cursor left-down-up-right (same as the vi editor)
* accompanying these with shift and/or control will multiply the step size by 2 and/or 4, respectively
* space or Enter will do the same as a mouse click at the current cursor location
* accompanying these with shift and/or control will function as a long hold
* If you enter a menu then:
    * hjkl or arrow keys will navigate the items as a matrix
    * space will toggle selections
    * Enter will function as "Ok"
    * ESC will function as "Cancel".

Historical note: Even though keyboard cursor control has been available by default for a long time, starting with version 3.01 it will require that you start hamclock with the ‑y command line option. I decided to disable it by default because too many people are laying things on their keyboard causing it to repeat endlessly, which sends zillions of commands to my server for hours on end without their realizing it. Note that ‑y only applies to cursor control; the Setup pages and menus continue to work the same as always with or without ‑y.

## 50.  How can I connect the photocell to an RPi hamclock?

You can not connect an actual photocell directly to an RPi because it has no ADC input.

But you can connect an LTR-329 light sensor via I2C. I use [this breakout from Adafruit](https://www.adafruit.com/product/5591). HamClock supports connecting it directly to the I2C pins 3 and 5 on the RPi 40 pin header, or using the USB-I2C bridge from i2cdriver.com. The bridge has the advantage that it will work on any UNIX system with a USB port, such as linux or macOS desktops. It even works on the RPi too, if you find USB to be more convenient than using the 40 pin header.

Once connected, the I2C light sensor supports the same HamClock functions as the photocell. See page 8 of the User Guide.

Note you can use the BME280 environment sensor in this manner also, see FAQ 45.

Unfortunately, I have not managed to get the native RPi I2C pins and the i2cdriver to work at the same time. So you must use one or the other for both BME280 and the LTR-392 light sensor.

## 51.  Why am I getting slow responses or lots of connection errors?

HamClock needs a good internet connection so check that first. For example check that ping clearskyinstitute.com reports no dropped packets and round-trip times of about 50 ms or better. On WiFi, check that your RSSI is at least -60 or above (HamClock reports the RSSI just below your call sign). Even with a good signal, you might have local RF interference being created by other devices or appliances. If in doubt, consider moving your HamClock closer to your WiFi router with a clear line-of-site.

If the network looks good, it might be my server has blocked your public IP address. As HamClock becomes more popular, it seems to be inevitable it will also attract a few who want to ruin it for the many and that is indeed the case.

To combat this, I have implemented a monitor on my server that temporarily blocks any IP that makes rapid repeated connections. I can tune the parameters but as of Jan 2024 the rate threshold is faster than one contact every four seconds sustained for a period of five minutes. Once blocked the IP will remain blocked, regardless of its contact rate, for three hours.

There is no legitimate HamClock usage that will cause a block but a few times I have found someone has a stuck keyboard or mouse button which causes HamClock to repeatedly make queries over and over.

If you feel you have been unfairly caught in my trap, feel free to make your case in an email to me at <ecdowney@clearskyinstitute.com>.

## 52.  Can I assign a password to certain sensitive commands?

Yes, but first an important warning:

I MAKE NO CLAIMS AS TO THE EFFECTIVENESS OF THIS FEATURE AND I ACCEPT NO RESPONSIBILITY IF IT IS BREACHED AND YOUR SYSTEMS ARE COMPROMISED. USE AT YOUR OWN RISK.

To assign a password to certain potentially sensitive operations within HamClock run it with the -p option, followed by the name of a text file containing pairs of categories and passwords. The file must be formatted according to the following rules:

* Empty lines and those beginning with # are ignored.
* All other lines must begin with a category followed by one or more spaces or tabs, then all remaining characters define its password, including any embedded spaces.
* Categories may appear in any order.
* Categories not in the file, or if misspelled, behave as if no password is required.
* Categories and passwords are both case sensitive
* The categories available as of HamClock V3.05 are:
* changeUTC exit newde newdx reboot restart setup shutdown unlock upgrade

For example, if a text file named hamclock_passwords.txt contains the following:

        # my hamclock passwords
        shutdown ^&%@JJH78
        unlock my unlock password

then enable the two passwords by running hamclock as:

        hamclock -p hamclock_passwords.txt

Implementation notes:

* As each password is read from the file, it is immediately hashed using a 32 bit CRC then the memory containing the password is reset to a fixed value. The hamclock process stores only this CRC value, not the plain text.
* Passwords entered in the GUI are hashed with the same algorithm and considered a match if the CRC values agree. The plain text passwords themselves are never compared.
* Of course the passwords still exist long term in the file specified with -p.
* IT IS THE RESPONSIBILITY OF THE SYSTEM ADMINISTRATOR TO SET ACCESS RIGHTS FOR THIS FILE AND TAKE OTHER STEPS AS NECESSARY TO PROTECT IT ACCORDING TO THE DESIRED SECURITY GOALS.
* These passwords do not apply to RESTful commands nor to commands engaged automatically via Demo mode.
* The list of categories can not be changed by the user. Send me a note if you would like to suggest additional categories.

## 53.  When I select a VOACAP DE-DX map why does it not stay visible?

Because it has been added to, and is rotating with, other map styles that are already selected.

As stated in the release notes, version 4.04 allows multiple background maps to be selected at the same time which then cycle, much the same as the data panes. So when you click VOACAP DE-DX for a REL or TOA map, it gets added to the current style list. Since they cycle, this causes the new map to appear to come and go.

The solution is just to turn off the map styles you don't want.

Now you might ask why HamClock doesn't just turn off all the other styles. The reason is that doing so creates the opposite problem of styles that had been manually selected mysteriously turning off, which is considered to be worse.

## 54.  Why are the VOACAP maps showing poor propagation everywhere?

Either the band you are showing really is pretty much shut down for some reason or because you have set HamClock to compute the long path.

You can toggle between long and short path by clicking LP/SP in the lower right corner of the DX panel or in the VOACAP DE-DX data pane.

## 55.  Why am I not seeing web pages open?

It depends on your configuration; take a look through these ideas:

* When running HamClock on a local display, it may be necessary to first start a browser by hand; HamClock is not always able to start one by itself.
* When running HamClock on a local display, HamClock runs xdg-open on most systems (all but macOS), so this helper program must be installed. See the Desktop tab for package name suggestions.
* When running HamClock remotely via ssh, it may attempt to display the page on the system on which HamClock is running, or it may attempt to start a new browser pointed back to the display from which ssh originated. It's not easy to predict which.
* When running HamClock in a browser, popups must be enabled. The details for doing this vary but the setting is usually in a section labelled Privacy or Security.
* In order to get biography pages for DX Cluster and On The Air spots you must first choose a source in Setup page 5.

## 56.  Can I use the little Raspberry Pi Zero for HamClock?

Yes, HamClock will run on any of the Pi Zero models, although somewhat more slowly of course.

The challenge is not running HamClock, it's building it because the compiler uses so much memory. One way to address this is to add a swap file. Do that by running the following commands first, then proceed with the installation:

        sudo fallocate -l 2G /var/swapfile
        sudo chmod 600 /var/swapfile
        sudo mkswap --label myswap /var/swapfile
        sudo swapon /var/swapfile

## 57.  How much data does HamClock use?

When HamClock is built for 800x480 each map is roughly 5 KB (kilobytes); the exact size varies because the maps are compressed but this is a good average. The maps scale by build area so maps for 1600x960 are 4x this size and so on.

Countries and Terrain are only downloaded one time; DRAP is downloaded every 5 minutes; MUF_RT every 15; Aurora and Weather every 30; all VOACAP maps every 45.

Selecting multiple map styles for rotation does not effect these numbers because the maps are cached locally until they need updating.

Maps that depend on DE or DX will require an immediate update if these locations change. The MUF-VCAP map is updated immediately whenever DE is changed. The VOACAP DE-DX TOA maps are updated immediately when first selected for each band and then again whenver DE is changed; the REL map is also updated for each band and whenever either DE or DX are changed.

The SDO images are 10 KB each when built for 800x480; again these scale by area for larger builds. The SDO image is refreshed every 30 minutes.

On a very busy contest weekend the DX Cluster pane my download 100 KB/hr, otherwise much less. The other panes may require roughly 10 KB/hr.

So, for example, if you build 1600x960, select DRAP and Aurora maps and the SDO pane then you will download 4*(5*(12 + 2) + 2*10) = 360 KB every hour, plus a little more for other data panes. These particular maps are not dependent on DE or DX so changing them will not require map updating. Or if you just select the Countries map alone, it is never updated so the only downloads are for the data panes.

## 58.  What is the history of HamClock?

The HamClock program began back in 2015 on the ESP8266 microprocessor in C++ with an 800x480 LCD touch screen. I used the Adafruit drawing libraries for all graphics. Since the ESP has only 80k RAM, all image processing was relegated to a backend server and image pixels were painted immediately as they arrived; there was no room for any kind of local backing store. Being a monolithic environment, the program was just an infinite loop of checking for touch screen events and drawing. All coordinates were native to the LCD.

Later as a first attempt to move HamClock to the Raspberry Pi, I wrote a drop-in replacement for the Adafruit library that maintained the same API methods but instead of writing pixels to the LCD the pixels were written to the raw frame buffer accessed as /dev/fb0. Raw keyboard events were collected from /dev/tty1 and raw mouse events from /dev/input. All drawing methods had to be reimplemented from scratch, for example using the famous Bresenham algorithm for drawing lines. Even the cursor has to be home-made, which is why HamClock to this day uses its own red arrow cursor. A new collection of fonts were also created and hidden within the Adafruit methods. This all worked out very well and is still the most efficient of all HamClock implementations for the RPi.

Later still I wrote another drop-in replacement for the Adafruit library that implemented display with X11 Windows and reading its mouse and keyboard events. Again, no X11 drawing functions were used, HamClock just continued to render the "LCD" as always but the porting layer was actually updating a memory array that was sent to the X client as a full screen bitmap once every 50 ms. For efficiency, only pixels that changed were sent over the wire. This worked surprisingly well with still no changes needed at all to the main program.

Later still I decided to try for higher screen resolutions. Drawing coordinates were still 800x480 but I built higher res images for the earth maps, VOACAP models, data panes etc. Since all images are created on my backend server, I could not afford to generate arbitrary sizes on the fly so I decided to support only three more sizes of 2x 3x and 4x the sizes needs for 800x480. These higher res images were still positioned to 800x480 precision but drawn to high resolution.

This worked well for the images but at larger screen sizes the 800x480 graphics drawing and fonts started to look pretty jagged. So for the first time I broke the Adafruit API by adding "raw" drawing methods such as drawLineRaw that worked in native coordinates. This fixed the drawing jaggies but the fonts were still just getting integer expanded. So following the same idea as the image sizes, I designed four new fonts, one for each of the four integer sizes. The font names are exactly the same regardless of size in order to hide from the main program that it is actually loading different font resolutions depending on the make build size. The fonts ended up looking pretty nice, although they are still always positioned to 800x480 accuracy.

Later still I added a web server that reads the same backing array already maintained for X11 but instead sends it to the web server as one large pixmap image, again only sending changed pixels. Browser events are sent back to hamclock, still using 800x480 coordinates. The client html is just a small page of javascript.

## 59.  Does HamClock save DX Cluster spots to a file?

Not to a separate file, but they are saved in the HamClock diagnostics file exactly as received from the cluster server except they are prefixed with a time stamp and module ID. For example, the following terminal command will list all spots from the currently running HamClock program:

        grep 'DXC: < DX de' ~/.hamclock/diagnostic-log.txt | cut -c 20-

## 60.  Why am I getting spots that don't match my watch list mode filter?

Because modes are determined by subband frequency ranges which are only loose conventions. And even if they were perfectly adhered to by all parties, they differ by region and country.

The way it should work is if the spotting networks had originally required mode to be explicitly specified by the spotter, but it's too late for that now.

## 61.  How can I become a beta tester?

By my invitation and your accepting responsibility to run relatively untested software. If we agree then I will send you a link to download a zip file with a name something like ESPHamClock-V4.14b10.zip. From there you install much like any hamclock:

        cd
        rm -fr ESPHamClock
        unzip ESPHamClock-V4.14b10.zip
        cd ESPHamClock
        make -j 4 hamclock-1600x960   (or as desired)
        sudo make install
        hamclock &

Once installed, HamClock will offer to update to all subsequent beta versions; you must decide whether you want to take the risk. Once a full release is issued and you update to it, you will be out of the beta program and must apply again.

## 62.  Why does the map start showing styles I have not selected?

If you are referring to DRAP or Aurora styles coming on by themselves, this is a feature. These values can increase very quickly so HamClock automatically selects them so you don't miss them.

DRAP is turned on if it rises above 25 MHz, and turns back off when it falls below 15 MHz. Aurora is turned on if the global likelihood becomes larger than 50%, and turns back off when it falls below 25%.

This feature can be disabled by turning off Auto SpcWx Map in Setup page 5.

## 63.  Is HamClock Open Source?

Partially, see [LICENSE](../LICENSE)

## 64.  My question is not here, where can I get help?

Send me a note at <ecdowney@clearskyinstitute.com> but beware:

* Be polite or your email will simply be discarded.
* If you installed or purchased HamClock using someone else's instructions, contact them, not me.

If you are submitting a bug report, always include:

* HamClock version
* platform: ES8266 or UNIX/linux platform, distro and version
* a clear and concise statement of what you expected to see ...
* ... what you actually see ...
* ... and instructions for how to reproduce the unexpected result.

If using any UNIX system, also include the following as you feel might be helpful:

* which make target you built
* display screen size and video type such as DSI or HDMI
* whether you are using VNC or a web connection
* whether you are using GUI in Full-screen mode
* pertinent Setup settings

Thank you. Your coorperation will help us both find a resolution to your issue more quickly.
