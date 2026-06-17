<div align="center">

# ❄️ anuj's dotfiles

**A declarative macOS workspace. Nix Flakes + nix-darwin + home-manager.**
**Apple Silicon (M1). Terminal-first. Opinionated. Zero bloat.**

[![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-000000?style=flat-square&logo=apple&logoColor=white)](#)
[![Nix Flakes](https://img.shields.io/badge/Nix-Flakes-7E9BE0?style=flat-square&logo=nixos&logoColor=white)](#)
[![nix-darwin](https://img.shields.io/badge/nix--darwin-system-7E9BE0?style=flat-square&logo=nixos&logoColor=white)](#)
[![home-manager](https://img.shields.io/badge/home--manager-24.05-7E9BE0?style=flat-square&logo=nixos&logoColor=white)](#)
[![arch](https://img.shields.io/badge/arch-aarch64--darwin-silver?style=flat-square&logo=apple&logoColor=black)](#)
[![shell](https://img.shields.io/badge/shell-zsh-89e051?style=flat-square&logo=gnubash&logoColor=white)](#)
[![stateVersion](https://img.shields.io/badge/darwin.stateVersion-5-success?style=flat-square)](#)

</div>

---

> Built for me — my current macOS, managed by Nix Flakes, nix-darwin and home-manager.
> Tried not to bloat it; only stuff I actually use daily. If you're somewhat like me, you'll like it.
> Clone it, rip out what you don't need, make it yours.

---

## 🧭 Overview

One `darwin-rebuild switch` and the machine is mine — Finder tamed, dock stripped, touch-ID-for-sudo on, apps installed, dotfiles symlinked, shell loaded with the tools I reach for. Wipe the Mac, run the command, come back to an identical machine.

Why Nix over a pile of `brew install` lists and `stow` symlinks:

- The same flake on the same commit produces the same system. No drift.
- Every change is a git commit. Roll back with `darwin-rebuild --rollback` — generations are kept on disk.
- A switch either fully applies or doesn't. No half-installed state when the network dies mid-brew.
- `darwin.nix` owns the system, `home.nix` owns the user, `dotfiles/` owns the program configs. Nothing lives only in a GUI preference pane.
- Need `k3d` + `opentofu` for one afternoon? `nix develop` into a throwaway flake. Main desktop stays clean. (Python, brew, and `pip` drama — if you know, you know. Nix sidesteps the whole mess.)

This is also my public proof of work. Not 400 stale shell aliases — a real, version-controlled, reproducible workstation.

---

## 📂 Repository Structure

```
dotfiles/
├── flake.nix          # entry point — inputs, outputs, darwinSystem
├── flake.lock         # pinned dependency graph (commit this, always)
├── darwin.nix         # system layer — Homebrew, macOS defaults, dock, users
├── home.nix           # user layer — CLI tools, shell, dotfile symlinks
└── dotfiles/
    ├── nvim/          # neovim config (lua)
    ├── aerospace/     # AeroSpace tiling WM config
    ├── ghostty/       # ghostty terminal config
    └── wallpaper.jpg  # the wallpaper
```

`flake.nix` wires it together — a `darwinConfiguration` named `anuj-macbook` on `aarch64-darwin`, pulling in `nix-homebrew` and `home-manager` as modules. The other three files own their layer and don't bleed into each other.

---

## ⚙️ What's Inside

### System (`darwin.nix`)
- `nix-homebrew` for declarative casks/taps. Rosetta off. Auto-migrate from legacy brew.
- Touch ID for `sudo` (`security.pam.services.sudo_local.touchIdAuth`).
- Finder: list view, pathbar + statusbar, all extensions + hidden files visible, desktop icons killed, search scoped to current folder, new windows open at `$HOME`.
- Key repeat cranked (`InitialKeyRepeat 15`, `KeyRepeat 2`), press-and-hold disabled, trackpad scaling 2.0, tap-to-click, three-finger drag. No auto-capitalization, no spell-correct.
- Dock: autohide, tile 57, magnify to 67, `scale` minimize, minimize-to-application, recents off. Only apps I actually use are pinned.
- Screenshots → `~/Pictures/Screenshots` as `.jpg`. No more 5MB PNGs on the desktop.
- Siri off, Time Machine nagging off, no `.DS_Store` on network/USB volumes.
- Loginwindow text: **"Stay Away — Anuj Pokhriyal"**.

### Apps (casks — declarative, no `brew install`-and-pray)
| App | Why it's here |
|---|---|
| **Ghostty** | Default look is so good I barely configure it. Written in Zig. |
| **AeroSpace** | Tiling WM in native Swift. No SIP disable like yabai — that's not cool. |
| **Zed** | Opens instantly, real vim bindings, written in Rust. I live in nvim; Zed is for when I actually need to code. |
| **Zen** | Arc that still gets updates. Firefox-based. f chrome. |
| **Helium** | Ungoogled, de-bloated Chromium for the few times Chromium is unavoidable. Sips RAM. |
| **OrbStack** | The Docker Desktop replacement on Apple Silicon. Sips CPU/RAM. Podman on macOS isn't there yet. |
| **Tailscale** | Mac as exit-node for my phones, reaching the homelab from anywhere. |
| **IINA** | Best video player on macOS. |
| **LocalSend** | Open-source AirDrop. |
| **Feishin** | Best-looking Navidrome client. Yes it's TypeScript — no better alternative exists. |
| **Shottr** | Miles better than default screenshots. Quick copy, annotate, done. |
| **Signal / WhatsApp / Telegram** | Privacy + reality of living in India. |
| **ImageOptim + Handbrake** | Trim photos/videos before they bloat my Immich server. |
| **AppCleaner** | Because macOS still doesn't know how to uninstall an app. |
| **Keka** | Because macOS also doesn't know how to handle zips properly. |
| **Impactor** | IPA sideloader for iPhone/iPad. FU to Apple for not letting me install what I want on devices I own. |
| **Hand Mirror** | Quick webcam check before hopping on a call. |

Deliberately **not** included(was there before):
- **Raycast** — wants to be everything, AI-this AI-that. Default Spotlight + the macOS 27 Siri updates are enough. Only thing missing was a clipboard manager and Spotlight's new update gets the job done. Still sucks, but okay.
- **Sketchybar** — pretty, but the real macOS menu bar is already there and I have to reach for it anyway. The new menu bar lets me remove/rearrange items now (groundbreaking, I know — they finally shipped it). No anxiety-inducing system meters I can already see.

### Userland (`home.nix`)
**CLI packages** (from `nixpkgs-unstable`):

| Tool | Why |
|---|---|
| **neovim** | The best editor. I keep it mostly default — no heavy modding. Config in `dotfiles/nvim/`. |
| **tmux** | Terminal multiplexer. You know why its here. |
| **starship** | So I don't have to configure oh-my-zsh and its bloat. Starship defaults are the best. |
| **zoxide** | `cd` with memory. `z proj` jumps to `~/code/projects` after one visit. |
| **fzf** | For the searches macOS Spotlight can't do. `--height 40% --border`. |
| **btop** | Activity Monitor is painfully slow. btop is faster — though it's inaccurate sometimes. |
| **yazi** | File explorer in the terminal. For when I don't want to leave the shell. |
| **fastfetch** | Updated neofetch. For those cool screenshots. |
| **tree** | Visual `ls` for viewing file/directory structure. |
| **pass** | Unix password manager. Replacing macOS Keychain (not fully migrated yet, but trying). |
| **android-tools** | `adb` into my Android TV and phones. |
| **cmatrix** | The Matrix screensaver. Pure flex for the screenshot. |

**Shell:** Zsh — macOS default. home-manager manages it: autosuggestions, syntax highlighting, completion, brew shellenv sourced on init. Starship prompt. Zoxide for `z`. fzf integrated with zsh.

**Dotfiles symlinked into place:**
```
dotfiles/ghostty/config  →  ~/Library/Application Support/com.mitchellh.ghostty/config
dotfiles/aerospace/      →  ~/.config/aerospace/
dotfiles/nvim/           →  ~/.config/nvim/
```

---

## 🚀 Installation & Setup

Tested on a fresh M1 MacBook Air. Read it through once before pasting.

### 0. Match the flake to *your* machine
These three strings are **mine**, not yours. Change them or the rebuild fails / produces a machine impersonating me:

| File | What | Change to |
|---|---|---|
| `flake.nix` | `darwinConfigurations."anuj-macbook"` | your hostname |
| `flake.nix` · `darwin.nix` | `anujpokhriyal` (username + `home`, 3 places) | your short username |
| `home.nix` | `programs.git.settings.user` (`"Your Name"` / `"your.email@example.com"`) | your git identity |

Check your current hostname first:
```bash
scutil --get LocalHostName
```
Either rename the machine (`sudo scutil --set LocalHostName "your-host"`) or edit `flake.nix` — your call.

### 1. Prerequisites
```bash
xcode-select --install
```

### 2. Install Nix (multi-user)
```bash
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
```
Restart your terminal, then verify:
```bash
nix --version
```

### 3. Enable flakes + nix-command
Already set declaratively in `darwin.nix` (`experimental-features = "nix-command flakes"`), but for the *first* run you need them on manually:
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### 4. Clone the repo
```bash
git clone https://github.com/anujj14/dotfiles.git ~/.config/darwin
cd ~/.config/darwin
```

### 5. First switch
```bash
nix run nix-darwin -- switch --flake .#anuj-macbook
```
(replace `anuj-macbook` with the hostname from step 0)

First run is slow — it's compiling/downloading your whole system. Subsequent runs are seconds.

After it finishes:
```bash
exec zsh
```
…and restart the Mac once so the system-level defaults (`dock`, `finder`, `loginwindow`) all pick up cleanly.

> If macOS prompts about `iina` or any app from an unidentified developer, approve it in **System Settings → Privacy & Security**. One-time thing.

---

## 🔁 Day-to-Day Usage

### Apply changes after editing the flake
```bash
cd ~/.config/darwin
darwin-rebuild switch --flake .#anuj-macbook
```
Edit → save → run. Idempotent — Nix computes the diff and only touches what changed.

### Update inputs (bump `flake.lock`)
```bash
nix flake update --flake .
darwin-rebuild switch --flake .#anuj-macbook
git add flake.lock && git commit -m "chore: bump flake inputs"
```
`flake.lock` is the reproducibility contract — always commit it. Do this every week or two to pull fresh `nixpkgs-unstable`.

### Roll back a bad switch
```bash
darwin-rebuild --rollback
# or pick a specific generation:
darwin-rebuild --list-generations
darwin-rebuild switch --generation <N>
```

### Garbage-collect old generations
```bash
nix-collect-garbage --delete-older-than 14d
```

### Quick reference
| Task | Command |
|---|---|
| Apply changes | `darwin-rebuild switch --flake .#anuj-macbook` |
| Update all inputs | `nix flake update --flake .` |
| Rollback | `darwin-rebuild --rollback` |
| List generations | `darwin-rebuild --list-generations` |
| Garbage collect | `nix-collect-garbage --delete-older-than 14d` |
| Inspect flake | `nix flake show` |
| Flake metadata | `nix flake metadata` |

---

## 🧪 Ad-hoc Dev Environments

The whole point of not bloating the main desktop. Drop a `flake.nix` in any project:

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { nixpkgs, ... }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [ python311 k3d opentofu kubectl helm ];
    };
  };
}
```

```bash
nix develop        # enter the env
exit               # leave it — nothing installed globally, nothing to uninstall
```

You know if you ever installed python in homebrew and tried using pip. Use nix isolated environment for moments you need that specific packages for work. Main Mac stays clean.

---

## 🛠 Customization Checklist

Before your first `darwin-rebuild switch`:

- [ ] `flake.nix` — rename `darwinConfigurations."anuj-macbook"` to your hostname
- [ ] `flake.nix` + `darwin.nix` — replace `anujpokhriyal` with your username (3 places)
- [ ] `home.nix` — set `programs.git.settings.user` name + email
- [ ] `darwin.nix` — review the `casks` list; delete what you don't want, add what you do
- [ ] `darwin.nix` — tweak `dock.persistent-apps` to match *your* dock
- [ ] `darwin.nix` — the `loginwindow.LoginwindowText` ("Stay Away — Anuj Pokhriyal") — make it yours or remove it
- [ ] `dotfiles/nvim/`, `dotfiles/aerospace/`, `dotfiles/ghostty/config` — these are *my* personal configs.

---

## 🫡 Acknowledgements

- [**LnL7/nix-darwin**](https://github.com/LnL7/nix-darwin) — declarative macOS.
- [**nix-community/home-manager**](https://github.com/nix-community/home-manager) — declarative home.
- [**zhaofengli/nix-homebrew**](https://github.com/zhaofengli/nix-homebrew) — declarative Homebrew.
- [**ChrisTitusTech**](https://www.youtube.com/watch?v=oafpwp0eon4) — the macOS rant video that helped with some macos configs. Also inspired for using nix.
- Everyone shipping the open-source apps above. 

---

<div align="center">

<sub>Built for me. Shared so you can build for you.</sub>

</div>
