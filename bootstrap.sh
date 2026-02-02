#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/<YOUR_GITHUB>/<YOUR_REPO>.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "==> Installing Nix (Determinate Systems installer)"

if ! command -v nix >/dev/null 2>&1; then
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install
else
  echo "Nix already installed, skipping"
fi

echo "==> Ensuring flakes are enabled"
mkdir -p "$HOME/.config/nix"
if ! grep -q "flakes" "$HOME/.config/nix/nix.conf" 2>/dev/null; then
  echo "experimental-features = nix-command flakes" >> "$HOME/.config/nix/nix.conf"
fi

echo "==> Cloning dotfiles repo"
if [ ! -d "$DOTFILES_DIR" ]; then
  nix shell nixpkgs#git -c git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "Dotfiles already cloned at $DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo "==> Activating Home Manager from flake"
nix run .#homeConfigurations."$USER@$(hostname)".activationPackage

echo ""
echo "✅ Done. Restart your shell."
