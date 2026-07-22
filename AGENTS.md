# NixOS Config (@gfors)

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/nixos-config#tbook --impure
```

Updates both NixOS system config and home-manager (user `gfors`) in one command.

## Directory Tree

```
nixos-config/
├── AGENTS.md                              # Panduan konfigurasi & catatan penting
├── flake.nix                              # Entrypoint: nixpkgs 26.05 + home-manager + spicetify-nix
├── flake.lock                             # Lockfile dependencies
├── .gitmodules                            # (kosong)
│
├── hosts/
│   └── tbook/                             # Host profile: tbook (x86_64-linux)
│       ├── default.nix                    #   Impor modul NixOS (core, hardware, desktop, services)
│       └── hardware-configuration.nix     #   Auto-generated — jangan diedit
│
├── modules/                               # System-level NixOS modules
│   ├── core/
│   │   ├── boot.nix                       #   systemd-boot + EFI
│   │   ├── networking.nix                 #   Firewall, KDE Connect ports (1714-1764), NetworkManager
│   │   ├── nix-settings.nix               #   Flakes, nix-command, GC auto (7d), unfree
│   │   └── users.nix                      #   User: gfors
│   │
│   ├── hardware/
│   │   ├── audio.nix                      #   PipeWire (pengganti pulseaudio)
│   │   ├── bluetooth.nix                  #   Bluetooth
│   │   └── intel-graphics.nix             #   Intel GPU (media-driver + vpl-gpu-rt)
│   │
│   ├── desktop/
│   │   ├── hyprland.nix                   #   Hyprland (diimpor — aktif)
│   │   └── kde-plasma.nix                 #   KDE Plasma 6 (ada tapi belum diimpor)
│   │
│   ├── services/
│   │   ├── docker.nix                     #   Docker
│   │   ├── flatpak.nix                    #   Flatpak
│   │   ├── mysql.nix                      #   MySQL
│   │   ├── power-profiles-daemon.nix      #   Power profiles
│   │   └── ssh.nix                        #   SSH server & client
│   │
│   └── common/
│       └── packages.nix                   #   Paket system-wide
│
└── home/                                  # Home-manager (user: gfors)
    └── profiles/
        └── tbook.nix                      # Entrypoint: impor semua modul shared/ (bukan home/default.nix)
            │
            └── shared/                    # Logical directory — diimpor eksplisit via tbook.nix
                ├── apps/
                │   ├── spotify.nix        #   Spotify (via spicetify-nix — flake sudah di-pass, blm dipakai)
                │   ├── vesktop.nix        #   Vencord desktop
                │   ├── alsa-tools.nix     #   ALSA tools
                │   ├── browsers.nix       #   Firefox/Chromium dll
                │   ├── tor-browser.nix    #   Tor Browser
                │   ├── mpv.nix            #   MPV
                │   ├── obs.nix            #   OBS Studio
                │   ├── gimp.nix           #   GIMP
                │   └── vlc.nix            #   VLC (belum diimpor)
                │
                ├── shell/
                │   ├── zsh.nix            #   Zsh + p10k (dari dotfiles eksternal)
                │   ├── tmux.nix           #   Tmux
                │   └── scripts/
                │       └── tmux-autostart.sh
                │
                ├── terminal/
                │   └── kitty.nix          #   Kitty terminal
                │
                ├── cli_tools/
                │   ├── opencode.nix       #   opencode AI CLI
                │   ├── yazi.nix           #   Yazi file manager
                │   ├── ffmpeg.nix         #   FFmpeg
                │   ├── ngrok.nix          #   ngrok
                │   └── posting.nix        #   Posting API client
                │
                ├── dev/
                │   ├── direnv.nix         #   Direnv
                │   ├── gcc.nix            #   GCC
                │   ├── git.nix            #   Git + SSH agent (id_ed25519_github)
                │   ├── go.nix             #   Go
                │   ├── nodejs.nix         #   Node.js
                │   ├── php.nix            #   PHP
                │   └── python.nix         #   Python
                │
                └── editor/
                    └── neovim.nix         #   Neovim
```

## Structure Overview

| Layer | Path | Deskripsi |
|---|---|---|
| **Flake** | `flake.nix` | Inputs (nixpkgs, home-manager, spicetify-nix) → `nixosConfigurations.tbook` |
| **System (NixOS)** | `hosts/tbook/` → imports `modules/*` | Boot, network, hardware, desktop, services |
| **User (home-manager)** | `home/profiles/tbook.nix` → imports `home/shared/*` | Aplikasi, shell, dev tools, CLI, editor |

## Key details

- **User**: `gfors` (shell: zsh, home: `/home/gfors`)
- **Boot**: systemd-boot with EFI
- **Desktop**: Hyprland (KDE Plasma 6 module tersedia tapi tidak aktif)
- **Audio**: PipeWire (replaces pulseaudio)
- **GPU**: Intel with `intel-media-driver` + `vpl-gpu-rt`
- **Firewall**: enabled, ports 1714-1764 (UDP/TCP) open for KDE Connect
- **Nix**: flakes + nix-command experimental features, auto GC (delete >7d), unfree packages allowed
- **Time zone**: Asia/Jakarta

## Quirks & gotchas

- `hardware-configuration.nix` is regenerated on hardware changes — do not hand-edit
- `home-manager` is used as a NixOS module (`useGlobalPkgs = true`, `useUserPackages = true`)
- `spicetify-nix` is a flake input and passed to home-manager via `extraSpecialArgs`, but **not used** in any home module yet
- `home/profiles/tbook.nix` is the home-manager entrypoint (not `home/default.nix` — file itu tidak ada)
- `modules/desktop/kde-plasma.nix` exists but is **not imported** in `hosts/tbook/default.nix` (Hyprland is active instead)
- `home/shared/apps/vlc.nix` exists but is **not imported** in `tbook.nix`
- Zsh config sources `~/.p10k.zsh` from an external `dotfiles` repo (`${config.home.homeDirectory}/dotfiles/zsh/.p10k.zsh`)
- SSH agent auto-starts; GitHub identity uses `~/.ssh/id_ed25519_github` with `IdentitiesOnly yes`
- `home.stateVersion` and `system.stateVersion` are both `"26.05"` — bump only on first install of a new release
- `.gitmodules` exists but is empty (no submodules currently)
