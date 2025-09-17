# mew
mew is a efficient dynamic menu for Wayland, an effective port of dmenu to Wayland.

## Building
In order to build mew, ensure that you have the following dependencies:

* fcft
* pkg-config
* wayland
* wayland-protocols
* xkbcommon

Afterwards enter the following command to build and install mew
(if necessary as root):
```
make
make install
```

## Usage
See the man page for details.

## Comparison

There are other menu programs or dmenu clones for Wayland, but there
are a few differences when it comes to accuracy, as mew is a full accurate
clone, while differing in the output select option due to the differences
between X and Wayland output/monitor design.

* [wmenu](https://codeberg.org/adnano/wmenu): A more modern dmenu clone,
  making it's own design choices (such as appearance and keybindings), not
  supporting bitmap fonts (Pango), and being fully rewritten from scratch as a
  fork of dmenu-wl.
* [bemenu](https://github.com/Cloudef/bemenu): Being a dynamic menu library
  and client program, it is very flexible, but comes at a cost of being
  unnecessarily complicated and large in codebase.
* [emenu](https://codeberg.org/fbushstone/emenu): Personally maintained fork
  of dmenu which adds wayland support, lacking git history. It is what
  mew hard forked from due to maintainership, consistency, and tidiness.
