# Opentrack Wine Guide

---

## What you'll find in this guide

This is a guide on how to compile and setup [Opentrack](https://github.com/opentrack/opentrack) on Linux and use it with Steam games running through the Proton compatibility layer.

---

## How to use this guide

This guide is divided in four parts.  

1. Setting up the environment [->](#setting-up-the-environment)
2. Compiling and installing Opentrack [->](#compiling-and-installing-opentrack)
3. Testing Opentrack [->](#testing-opentrack)
4. Using Opentrack with Steam games

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
> $ sudo apt install make cmake cmake-curses-gui qttools5-dev qtbase5-private-dev libprocps-dev libopencv-dev libevdev-dev wine-stable wine32-development wine32-tools wine32-development-tools
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
$ cd $OPENTRACK_SRC_DIR           # Change directory OPENTRACK_SRC_DIR
$ mkdir build                 # Create a directory called "build" (needed by cmake)
$ cd build                    # Change directory to "build"
$ cmake ..                    # Setup build with the default parameters
$ ccmake .                    # Run the build configurator 
```

Your terminal window should now be displaying a TUI like the one displayed in the gif below.  
Here you have to set the following options:

- `CMAKE_INSTALL_PREFIX` to the install directory (I recommend using `/home/<username>/.local`).
- `SDK_WINE` from `OFF` to `ON`.
- **(OPTIONAL)** `SDK_XPLANE` to the directory where you downloaded the X-Plane SDK.

**IMPORTANT**: Use as an install location a directory that does not require root privileges to read or write or execute.  

**NOTE: How to navigate ccmake menus (in case you have the attention span of a fish, just like me)**  
You can use the `UP` and `DOWN` arrows to change field. Press `SPACE` to toggle `SDK_WINE` from `OFF` to `ON` and vice versa. To change `CMAKE_INSTALL_PREFIX` or `SDK_XPLANE` (or any other string entry) press `ENTER` to enter edit mode and use the `LEFT` and `RIGHT` arrows to move the cursor, `DELETE` or `BACKSPACE` to delete characters; once you're done editing the value you can exit edit mode by pressing `ENTER` again. If you want to exit edit mode without saving your changes, press `ESC`.  
**Be careful**: pressing the `UP` or `DOWN` arrows while in edit mode will save your changes and put you back in the main menu.  

Once you have modified the options mentioned above press `c` (to configure the build) and `g` (to generate the Makefile). If everything has gone smoothly, `ccmake` should return to the terminal. If instead `ccmake` throws an error, try deleting the `build` directory and try again from the second command ([here](#compiling-and-installing-opentrack)).

Here's a demo of the `ccmake` configuration process:  

![CCMake setup demo](resources/images/ccmake-demo.gif)  

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

## Testing Opentrack

From this point on I will refer to the install directory specified in `CMAKE_INSTALL_PREFIX` as `OPENTRACK_INST_DIR`.  


