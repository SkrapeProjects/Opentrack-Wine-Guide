# Opentrack Wine Guide

---

## What you'll find in this guide

This is a guide on how to compile and setup [Opentrack](https://github.com/opentrack/opentrack) on Linux and use it with Steam games running through the Proton compatibility layer.

---

## How to use this guide

This guide is divided in four parts.  

1. Setting up the environment [->](#setting-up-the-environment)
2. Compiling and installing Opentrack
3. Testing Opentrack
4. Using Opentrack with Steam games

For any issues please refer to the project's [issues page](https://github.com/SkrapeProjects/opentrack-wine-guide/issues).  

**NOTE**  
This guide was written for Debian based systems. Instructions for other distributions will be added in the future. If you would like to contribute to this project, please feel free to do so by opening a pull request [here](https://github.com/SkrapeProjects/opentrack-wine-guide/pulls).

---

## Definitions

- If there's a `$` before a command, execute that command as a normal user  

---

## Setting up the environment

### Install dependencies

Make sure you have installed the dependencies by running the command listed for your system.

> #### Ubuntu/Debian

> ```
> $ sudo apt install cmake cmake-curses-gui qttools5-dev qtbase5-private-dev libprocps-dev libopencv-dev libevdev-dev wine-stable wine32-development wine32-tools wine32-development-tools
> ```  

**IMPORTANT**: Make sure your Wine version is <=5.6
