# Flatpak Wine Runtime

This is a very early and not well though-out exploration into the idea of packaging Wine/Windows
apps as Flatpaks.

## The problem

The idea of running Wine apps in the Flatpak sandbox is not new, but never before a Wine app was
packaged, meaning, the app wasn't installed into the local user/system Flatpak repository.  
In other words, the Wine prefix was created outside of the local Flatpak repositry.  

## Solution

Install the apps during the apply extra step.

## Packaging examples

**Warning: These are PoC, and not ready for use**

* [Apple AirPort Utility](https://github.com/tinywrkb/flatpaks/tree/master/com.apple.airport-utility)
* [Notepad++](https://github.com/tinywrkb/flatpaks/tree/master/org.notepad_plus_plus.notepadpp)
