# Flatpak Wine Runtime

This is a very early and not well thought-out exploration into the idea of packaging Wine/Windows
apps as Flatpaks.

The idea of running Wine apps in the Flatpak sandbox is not new, but previous examples were creating
the Wine prefix outside of the local Flatpak repositry, and at best, packaging the installer.  

This runtime offers the possibility of adding a Wine prefix to the local Flatpak installation
(system/user).  
This is done by deploying a Wine prefix during the apply extra step, and running the installer
executable during this step to install the Wine app into the prefix.  
Packaging the Wine app this way gives us an app that is fully managed by Flatpak.  
Thus this approach can be called Flatpak-managed Wine packaging.

### Pros

* Wine apps are fully managed by Flatpak.
* No need to run an installer after the Flatpak was installed.
* The prefix is recreated on every update so no need to script an update helper.
* Removing an app removes the prefix with the Wine app installation.
* Removing the app's `.var` folder just reset to a clean state, but doesn't affect the prefix.
* The installation is shared between users, saving storage space.
* Packaging defines a specific, optionally stable, runtime version, and the prefix is recreated
  when the packaging is update, so broken symlinks is not an issue, and storage space can be saved
  by using symlinks in the prefix.

### Cons

* Need to be able to identify post-installation registry changes, export them, and re-apply after
  an update of the Flatpak app or rollback.
* Questionalbe Windows app packaging practices make it close to impossible to run the app from
  a read-only path.  
  Specifically, self-updated Windows apps that are installed into AppData are a PITA deal with.

## Packaging examples

**Warning: These are PoC, and not ready yet**

* [Apple AirPort Utility](https://github.com/tinywrkb/flatpaks/tree/master/com.apple.airport-utility)
* [Notepad++](https://github.com/tinywrkb/flatpaks/tree/master/org.notepad_plus_plus.notepadpp)


## TODO

### packaging
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
* [ ] more fonts?

### libs and tools to evaluate and add
* [ ] dxvk-ags
* [ ] dxvk-nvapi
* [ ] vkd3d-proton
* [ ] WineASIO, apps to test with:
  * [ ] [Ableton Live](https://www.ableton.com/en/trial/)
  * [ ] [FL Studio](https://www.image-line.com/fl-studio-download/)
  * [ ] [Amplitube](https://www.ikmultimedia.com/products/amplitube4/)

### sdk environment
* [ ] helper scripts to build wine
* [ ] app packaging documentation and examples
* [ ] code examples
  * [ ] building and linking against dlls
  * [ ] building and linking wine's elf shared libs instead of dlls
  * [ ] using different toolchains
    * [ ] mingw
    * [ ] msvc

## Wishlist

* [ ] [vinebooth](https://github.com/tinywrkb/vinebooth): Wine Flatpak bootstrap. **Status: WIP**
* [ ] fur: Flatpak User Repository
  * Objective: Solve the source fetch problem
  * Problem: It's not unusual that downloading a Windows app requires the user to authenticate,
    subscribe, or use a temporary download URL, and make it impossible to fetch an installer
    with Flatpak.  
    Even when a download URL is available, there's no releases archive. This means that when a new
    version is released, the download URL won't work or the installer will change (size, checksum),
    and this will end with a time window where the Flatpak is broken until an update is propagate
    down to the user.
    This issue makes these apps less fitting for Flathub publishing.
  * Solution: Build the app locally, and let the user select the installer. And in detail:
    * Automate fetching Flatpak packaging manifests
    * Build apps into a local Flatpak repository using the cache of downloaded packaging manifests
    * Before building an app, let the user select a local file matching the extra-data source entry
      or be used to update it, will be copied into `FLATPAK_INSTALLATION_DIR/extra-data/CHECKSUM/filename`.
  * Other features:
    * A real user repository, meaning supporting multiple repositories, not built around a single
      repository.
    * Support Git repo per app, and `flatpaks` repo, a Git with multiple apps.
    * Instead of the extra-data cache, start a local HTTP server and make the file available to
      the local machine.
