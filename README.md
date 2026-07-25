# Dotfiles

Personal configuration for an Arch Linux + i3 setup. These dotfiles live in
`~/.dotfiles` and are deployed into place with symlinks, so the repository stays
the single source of truth: edit a file here, and the change is live everywhere
it is linked.

## What's inside

| Path | Purpose |
| --- | --- |
| `.zshrc`, `.zprofile` | Zsh shell config (aliases, prompt, vi-mode, fzf, plugins) |
| `.bashrc`, `.bash_profile` | Bash fallback config |
| `.xinitrc` | X session startup — launches i3 by default |
| `.Xresources`, `.Xmodmap` | Terminal colors / fonts and keyboard remaps |
| `.gitconfig` | Git identity, editor, diff tool |
| `.config/i3/` | i3 window manager config |
| `.config/polybar/` | Status bar |
| `.config/nvim/` | Neovim config (`init.vim` + per-filetype `ftplugin/`) |
| `.config/lf/` | `lf` terminal file manager |
| `.config/mpv/`, `.config/zathura/` | Video player, PDF viewer |
| `.config/picom/` | Compositor |
| `.config/mimeapps.list` | Default applications |
| `pacman.conf` | System pacman config (symlinked to `/etc`) |
| `packages/` | Package lists + install/update scripts |
| `symlinks.sh` | Deploys all configs into place |
| `golink`, `usb-mount`, `config_edit`, `empty_trash` | dmenu-driven helper scripts (symlinked to `/usr/bin`) |
| `arxiv_pdf.sh`, `water_mark.sh` | Standalone utility scripts |
| `40-libinput.conf` | Touchpad / input device tuning |

## Fresh install

These steps assume a base Arch install with `git` available and the repo cloned
to `~/.dotfiles`.

```bash
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
```

### 1. Install packages

`packages/install-packages.sh` installs every native package from
`pkglist.txt`, bootstraps the `yay` AUR helper if it is missing, then installs
the AUR packages from `pkglist-aur.txt`.

```bash
./packages/install-packages.sh
```

> Needs `sudo`. Safe to re-run — `--needed` skips anything already installed.

### 2. Deploy the configs

`symlinks.sh` copies the `.config/*` trees into `~/.config` as symlinks
(`cp -rs`, so individual files point back here) and symlinks the home-directory
and system files.

```bash
./symlinks.sh
```

What it does:

- `~/.config/{lf,nvim,zathura,i3,mpv,picom,polybar,mimeapps.list}` → symlinks into this repo
- `~/.gitconfig`, `~/.xinitrc`, `~/.Xmodmap`, `~/.Xresources`, `~/.zshrc`, `~/.zprofile` → symlinks
- `/etc/pacman.conf` → symlink (needs root)
- `golink`, `empty_trash`, `config_edit`, `usb-mount` → symlinked into `/usr/bin` (needs root)

> **Heads up:** the script does not remove pre-existing files first, so `ln -s`
> will fail on anything that already exists. Move or delete conflicting files
> (e.g. an existing `~/.zshrc`) before running, or run the lines individually.
> Paths are hard-coded to `/home/han` — adjust them if your username differs.

### 3. Start X

```bash
startx        # reads ~/.xinitrc, which execs `i3`
```

`.xinitrc` accepts a session name as `$1` (e.g. `startx kde`) but defaults to
i3.

## Day-to-day usage

### Keeping package lists current

After installing or removing packages, regenerate the lists so the repo matches
your machine, then commit:

```bash
./packages/update-packages.sh   # writes pkglist.txt + pkglist-aur.txt
gitu "Update package lists"      # add + commit (alias, see below)
```

`update-packages.sh` records explicitly-installed native packages
(`pacman -Qqen`) and AUR packages (`pacman -Qqem`, minus `-debug`).

### Shell helpers (defined in `.zshrc`)

| Alias / function | Action |
| --- | --- |
| `nav` | `lf` file manager that `cd`s to the directory you quit in |
| `vim` | `nvim` |
| `vmm` | open `main.tex` in nvim |
| `ex <file>` | extract any archive by extension |
| `gitu [msg]` | `git add .` + commit (default message `Update`) |
| `gitnu [msg]` | copy `main.pdf` to note folders, then add + commit |
| `wifi` / `bluetooth` / `volume` | `nmtui` / `bluetoothctl` / `pavucontrol` |
| `monitor` / `monitor-on` | toggle external display via xrandr |
| `newterm` | spawn a detached `st` terminal |

The shell uses **vi keybindings** (`bindkey -v`); press `Esc` then `v` to edit
the current command line in `$EDITOR`. fzf and zsh autosuggestions /
syntax-highlighting are loaded if installed.

### dmenu helper scripts (on `$PATH` after `symlinks.sh`)

- **`golink`** — pick a bookmark from `urls.txt` via dmenu and open it in the
  browser. Unknown names prompt for a URL and get appended. Entries ending in
  `=` (search URLs) prompt for query terms. Edit `urls.txt` to manage bookmarks.
- **`usb-mount`** — dmenu menu to mount/unmount USB partitions under `~/USB`.
- **`config_edit`** — dmenu menu to jump straight into editing a config file.
- **`empty_trash`** — clears the trash and ctpv preview cache.

### i3 cheat sheet

Mod key is **Alt** (`Mod1`). Highlights:

| Key | Action |
| --- | --- |
| `Mod+Return` | terminal (`st`) |
| `Mod+d` | `dmenu_run` |
| `Mod+Shift+q` | kill window |
| `Mod+h/j/k/l` | focus left/down/up/right |
| `Mod+Shift+h/j/k/l` | move window |
| `Mod+1..0` | switch workspace |
| `Mod+Shift+1..0` | move window to workspace + follow |
| `Mod+f` | fullscreen |
| `Mod+s` / `Mod+w` / `Mod+e` | stacking / tabbed / toggle split layout |
| `Mod+Shift+space` | toggle floating |
| `Mod+r` | resize mode |
| `Mod+Shift+x` | lock screen (`betterlockscreen`) |
| `Mod+Shift+g` | gaps mode |
| `Mod+Shift+r` | restart i3 in place |
| `Mod+Shift+e` | exit i3 |

Volume / brightness keys (`XF86Audio*`, `XF86MonBrightness*`) are wired to
`wpctl` and `brightnessctl`. Full config: `.config/i3/config`.

## Making changes

Because everything is symlinked, just edit the file in `~/.dotfiles` (or via the
live symlink — same inode) and commit:

```bash
cd ~/.dotfiles
$EDITOR .config/i3/config
gitu "i3: tweak gaps"
```

For i3 changes, reload with `Mod+Shift+c` (reload config) or `Mod+Shift+r`
(restart in place).

## Notes & caveats

- Paths in `symlinks.sh` and several scripts are hard-coded to `/home/han`.
  Find-and-replace your username before using on another machine.
- `symlinks.sh` is not idempotent against existing files — clear conflicts first.
- `.gitignore` excludes `spell/` (nvim spell files).
- Designed for Arch Linux; the package scripts assume `pacman` + `yay`.
</content>
</invoke>
