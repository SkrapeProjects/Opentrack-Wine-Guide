# Opentrack Wine Guide

---

## Automated build scripts

Scripts for automating the build process are now available [here](https://github.com/SkrapeProjects/opentrack-wine-guide/tree/main/build_scripts).

---

## What you'll find in this guide

This is a guide on how to compile and setup [Opentrack](https://github.com/opentrack/opentrack) on Linux and use it with Steam games running through the Proton compatibility layer.

---

## How to use this guide

This guide is divided in three parts.  

1. Setting up the environment [->](#setting-up-the-environment)
2. Compiling and installing Opentrack [->](#compiling-and-installing-opentrack)
3. Using Opentrack with Steam games [->](#using-opentrack-with-steam-games)

For any issues please refer to the project's [issues page](https://github.com/SkrapeProjects/opentrack-wine-guide/issues).  

**NOTE: I use Ubuntu btw**  
This guide was written for Debian based systems. Instructions for other distributions will be added in the future. If you would like to contribute to this project, please feel free to do so by opening a pull request [here](https://github.com/SkrapeProjects/opentrack-wine-guide/pulls).

---

## Definitions

- If there's a `$` before a command, execute that command as a normal user  

---

## Setting up the environment

### Installing the dependencies

Make sure you have installed all the required dependencies by running the command listed for your system.

> #### Ubuntu/Debian

> ```
> $ sudo apt install build-essential cmake cmake-curses-gui qttools5-dev qtbase5-private-dev libprocps-dev libopencv-dev libevdev-dev gcc-multilib g++-multilib wine-stable wine32-development wine32-tools wine32-development-tools
> ```  

> #### Fedora

> ```
> $ sudo dnf install qt5-qtbase-private-devel qt5-qttools-devel procps-ng-devel opencv-devel libevdev-devel qt5-qtserialport-devel make cmake unzip gcc g++ glibc-devel.i686 libstdc++-devel.i686 wine wine-devel.i686
> ```

**IMPORTANT**: Make sure your Wine version is <=5.6  

<br/>

### Downloading Opentrack

Head over to [Opentrack's releases page](https://github.com/opentrack/opentrack/releases) and download the latest available release's source code (either as zip or tar.gz).  
Open the directory where you have downloaded the file and extract it.  
You should now have a folder named `opentrack-opentrack-<major>.<minor>.<patch>` containing Opentrack's source code. I'll refer to this folder as `OPENTRACK_SRC_DIR` for the rest of this guide.  

---  

## Compiling and installing Opentrack  

Run the following commands in the same order they've been written:

```
$ cd $OPENTRACK_SRC_DIR       # Change directory OPENTRACK_SRC_DIR
$ mkdir build                 # Create a directory called "build" (needed by cmake)
$ cd build                    # Change directory to "build"
$ cmake ..                    # Setup build with the default parameters
$ ccmake .                    # Run the build configurator 
```

Your terminal window should now be displaying a TUI like the one displayed in the gif below.  
Here you have to set the following options:

- `CMAKE_INSTALL_PREFIX` to the install directory (I recommend using `/home/<your_username>/.local`).
- `SDK_WINE` from `OFF` to `ON`.
- **(OPTIONAL)** `SDK_XPLANE` to the directory where you downloaded the X-Plane SDK.

**IMPORTANT**: Use as an install location a directory that does not require root privileges to read or write or execute. Also, if you use the path I recommended, I suggest you specify the entire path as I've written it (just remember to replace `<your_username>`), I found it to be pretty hit or miss otherwise.

**NOTE: How to navigate ccmake menus (in case you have the attention span of a fish, just like me)**  
You can use the `UP` and `DOWN` arrows to change field. Press `SPACE` to toggle `SDK_WINE` from `OFF` to `ON` and vice versa. To change `CMAKE_INSTALL_PREFIX` or `SDK_XPLANE` (or any other string entry) press `ENTER` to enter edit mode and use the `LEFT` and `RIGHT` arrows to move the cursor, `DELETE` or `BACKSPACE` to delete characters; once you're done editing the value you can exit edit mode by pressing `ENTER` again. If you want to exit edit mode without saving your changes, press `ESC`.  
**Be careful**: pressing the `UP` or `DOWN` arrows while in edit mode will save your changes and put you back in the main menu.  

Once you have modified the options mentioned above press `c` (to configure the build) and `g` (to generate the Makefile). If everything has gone smoothly, `ccmake` should return to the terminal. If instead `ccmake` throws an error, try deleting the `build` directory and try again from the second command ([here](#compiling-and-installing-opentrack)).

Here's a demo of the `ccmake` configuration process:  

![ccmake-setup-demo](resources/images/ccmake-demo.gif)  

Once you're back in the terminal, check you're still in the `build` directory and type the following commands (in order):

```
$ make -j$(nproc)           # Build Opentrack
$ make install              # Install Opentrack in the location specified in CMAKE_INSTALL_PREFIX
```

Remember to check for errors.  
If there are none, congratulations, you have just successfully compiled and installed Opentrack on your system!  
Just head over to the directory you set as `CMAKE_INSTALL_PREFIX` and check if all the files are present. Your file structure should look like this:  

```
.
├── bin
│   └── opentrack       # Executable
├── libexec
│   └── opentrack       # Directory (make sure it contains "opentrack-wrapper-wine.exe.so")
└── share
    ├── doc             # Directory
    └── opentrack       # Directory
```  

---

## Using Opentrack with Steam games

Before setting up to work with Proton you must make sure that both the game you want to use with Opentrack and the Proton version you use for that game are installed on the main Steam library (the one located in `~/.local/share/Steam/steamapps`). 

<br/>

### Common problems (please read them)

> #### How do I move Proton? It doesn't show up in Steam!

> Open Steam and go to your library. Click on the top left box where it says `Games and Software` or `Games` and check that the box on the left of `Tools` is checked.

> ![show tools](resources/images/show-tools.jpg)

> #### But I don't have enough space on my main drive!

> Allow me to introduce you to the beauty of symlinks.  
> If you can't install either Proton or your game on your main drive you can just create a symlink to it.  
> This is the process I follow for my games.  

> 1. Create a Steam library on the secondary drive
> 2. Install the game to the library you just created
> 3. After the game has finished installing, right click on it then go to  
> `Properties > Local Files > Browse`
> 4. Go up a folder, and copy the entire game folder to a new destination **outside the Steam library**
> 5. Finally create a new symlink for that folder in the `~/.local/share/Steam/steamapps/common` directory using the following command:  

> ```
> $ ln -s /path/to/game/folder/<game_folder_name> ~/.local/share/Steam/steamapps/common
> ```

> **EXAMPLE**  
> I install all my games in a folder named `Games` on an hard drive I mount at `/media/data`. Let's say I want to use Opentrack with DCSWorld. The command I would have to run to create the symlink would be:

> ```
> $ ln -s /media/data/Games/DCSWorld ~/.local/share/Steam/steamapps/common
> ```

> **NOTE: Making sure the symlink is correct**  
> To check if the symlink was created correctly you can run:

> ```
> $ file ~/.local/share/Steam/steamapps/common/<game_folder_name>
> ```

> The output should be:

> ```
> /home/<your_username>/.local/share/Steam/steamapps/common/<game_folder_name>: symbolic link to /path/to/game/folder/<game_folder_name>
> ```  

> #### But I only install games on my secondary drive!

> **TL;DR**: Just symlink the fricking `steamapps` directory.  
> Follow these steps:

> 1. Quit Steam
> 2. Open the `~/.local/share/Steam` folder in your favourite file manager (`.local` is a hidden folder, user `CTRL + H` to show it).
> 3. Move the entire `steamapps` directory to your secondary drive or merge it with the one in an existing Steam library
> 4. Create a symlink to the `steamapps` directory in the new location with the following command:

> ```
> $ ln -s /path/to/where/you/put/steamapps ~/.local/share/Steam/
> ```

> 5. Check if the symlink was successfully created by using:

> ```
> $ file ~/.local/share/Steam/steamapps
> ```
 
> 6. If the output is not the following, you messed something up:

> ```
> /home/<your_username>/.local/share/Steam/steamapps: symbolic link to /path/to/where/you/put/steamapps
> ```

<br/>

### Setting up Opentrack

Start by setting up your input.  
This is not a tutorial on how to use Opentrack (at least not yet), so I'm going to take it for garanted you already know how to do it. If this is your first time using Opentrack, please refer to [Opentrack's Wiki](https://github.com/opentrack/opentrack/wiki).  

**NOTE: FreePIE**  
If you don't have the equipment for IR tracking but you have an Android phone (like the guy who's writing this), you can try using FreePIE.  

It's now time to set out the output.  

1. Click on the dropdown menu under `Output`
2. Select `Wine -- Windows layer for Unix`
3. Click on the button on the right to the dropdown menu (it should display a hammer but it doesn't render on certain DEs)
4. On the window that appears select the following settings:
    - Under `Wine variant` select `Proton (Steam Play)` and select the correct Proton version for the game you want to play
    - Under `Advanced`:
        - Make sure both `ESYNC` and `FSYNC` are checked
        - Select `Both` from the dropdown menu for `Protocol`
        - In the text box on the right of `Steam application id`, type the App ID for the game you want to play. If you don't know the right App ID for your game you can look it up on [SteamDB](https://steamdb.info)
    - Click on `OK` to save the changes

Visual instructions:  

![opentrack instruction main](resources/images/opentrack-instr-main.jpg)  
![opentrack instruction advanced](resources/images/opentrack-instr-adv.jpg)  

#### What if I want to use Opentrack with multiple games?

In this case, I recommend creating a profile for each game you want to use Opentrack with. Just create a new profile and repeat the process above. By doing this you can just choose the profile for the game you want to play, without having to edit you settings all over.

<br/>

### Starting the game

1. Launch Opentrack
2. Select the profile for the game you want to run or setup Opentrack by following [these steps](#setting-up-opentrack)
3. Launch the game through Steam
4. Click the `Start` button on Opentrack
5. Head tracking should now be working!

**NOTE: Start tracking automatically**  
You can also set Opentrack to start tracking when a game starts. You can do this by clicking on the `Options` button, then going to the `Game detection` tab and ticking the `Start profiles from game executable in this list` checkbox. Click on the `+` button on the bottom, an entry should appear in the list. Select the profile to run from the dropdown menu under the `Profile` column, then select the game executable that Steam launches by clicking on the `...` button on the right of the dropdown menu.
