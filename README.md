# Dotfiles — Nix Flake + Home Manager

This repository defines my entire development environment using:

* **Nix flakes**
* **Home Manager**
* **Determinate Systems Nix installer**

The goal is simple:

> On a brand new machine → run one command → get my full environment.

No Homebrew. No manual dotfile copying. No ordering issues.

---

## 🚀 Bootstrap a new machine (macOS / Linux)

On a fresh machine, run:

```bash
curl -fsSL https://raw.githubusercontent.com/KentaKudo/dotfiles/main/bootstrap.sh | bash
```

This will:

1. Install **Nix** using the Determinate installer
2. Enable flakes
3. Clone this repo to `~/dotfiles`
4. Activate Home Manager directly from the flake

When it finishes, **restart your shell**.

You are done.

---

## 🧠 What this repo manages

Everything is declarative via Home Manager:

* Packages (`git`, `tmux`, `ghq`, `ripgrep`, etc.)
* Shell config (zsh/bash)
* Git config
* Tmux config
* Tool/editor config files
* Any other dotfiles

The machine only needs to be capable of running `nix`.

---

## 🔄 Apply changes after editing config

After changing `flake.nix`, `home.nix`, etc.:

```bash
hms
```

If this command fails, check the `outputs` section of `flake.nix`.
