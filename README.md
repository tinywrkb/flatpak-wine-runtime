# Flatpak Wine Runtime

This is a very early and not well thought-out exploration into the idea of packaging Wine/Windows
apps as Flatpaks.

The idea of running Wine apps in the Flatpak sandbox is not new, but previous examples were creating
the Wine prefix outside of the local Flatpak repositry, and at best, packaging the installer.  

This runtime offer the possibility of adding a Wine prefix to the local Flatpak (system/user).  
This is done by deploying a Wine prefix during the apply extra step, and running the installer
executable during this step to installing the Wine app into the prefix.  
Packaging the Wine app this way gives us an app that is fully managed by Flatpak.  
Thus this approach can be called Flatpak-managed Wine packaging.


## Packaging examples

**Warning: These are PoC, and not ready yet**

* [Apple AirPort Utility](https://github.com/tinywrkb/flatpaks/tree/master/com.apple.airport-utility)
* [Notepad++](https://github.com/tinywrkb/flatpaks/tree/master/org.notepad_plus_plus.notepadpp)


## TODO

### packaging
* [ ] **(WIP)** add [vinebooth](https://github.com/tinywrkb/vinebooth): Wine Flatpak bootstrap
* [ ] mt32emu f-e-d-c
* [ ] wine-gecko f-e-d-c or fix the check in the anitya project page
* [ ] set no-debuginfo and strip to avoid flatpak-builder constantly attempting to compress wine libs
* [ ] evaluate packaging a wine prefix: machids, uuids, hw identifiers
* [ ] drop cups module in favour of the runtime supplied one
* [ ] switch master to the latest development release and add branches
  * [ ] master: latest development release built on top the latest freedesktop runtime
  * [ ] wayland (collabora)
  * [ ] wayland (varmd)
  * [ ] wine6 or wine6-21.08: latest stable
  * [ ] staging
  * [ ] staging6 or staging6-21.08
  * [ ] lutris
  * [ ] lutris6 or lutris6-21.08
* [ ] add a wine Flatpak app: user managed prefices and to testing and development helper
  * [ ] add desktop files and mimetypes for wine programs
  * [ ] add a simple wine prefices manager. use runtime wine, so not bottles nor lutris

### fonts
* [ ] fontconfig's conf.d
* [ ] add [corefonts](http://corefonts.sourceforge.net/), [see](https://en.wikipedia.org/wiki/Core_fonts_for_the_Web), and [gentoo's packaging](https://packages.gentoo.org/packages/media-fonts/corefonts)
* [ ] tahoma: compare glyph coverage of wine's vs original
* [ ] investigate font related errors, specifically Noto Fonts related

### libs and tools to evaluate and add
* [ ] dxvk-ags
* [ ] dxvk-nvapi
* [ ] vkd3d-proton
* [ ] WineASIO

### sdk environment
* [ ] helper scripts to build wine
* [ ] app packaging documentation and examples
* [ ] code examples
  * [ ] building and linking against dlls
  * [ ] building and linking wine's elf shared libs instead of dlls
  * [ ] using different toolchains
    * [ ] mingw
    * [ ] msvc
