
---

# Z-xus's Arch Linux Dotfiles

Welcome to my Arch Linux dotfiles repository! These dotfiles are a culmination of months of customization, refinement, and optimization to create a streamlined and efficient development environment on Arch Linux.
(Took me almost a year's grind)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Clone and Setup](#clone-and-setup)
- [Tools & Configurations](#tools--configurations)
  - [Zsh & Plugins](#zsh--plugins)
  - [Neovim](#neovim)
  - [i3 Window Manager](#i3-window-manager)
  - [Others](#others)
- [Customization](#customization)
- [Credits](#credits)
- [License](#license)

## Overview

This repository contains my personal configuration files for Arch Linux, tailored to suit my workflow and preferences. It includes configurations for Neovim, i3 window manager, and all my favorite tools.

## Features

- **Neovim Setup**: A powerful IDE-like experience with plugins and keybindings tailored for efficient coding.
- **i3 Window Manager**: A minimalist, highly customized tiling window manager setup.
- **Zsh with Powerlevel10k**: A highly Zsh Zen config setup with plugins for enhanced productivity.
- **Custom Scripts**: Handy scripts to automate daily tasks.
- **Modular Configuration**: Easy to extend and customize according to your needs.

## Installation

### Prerequisites

- Arch Linux
- Git
- `yadm`

### Clone and Setup

1. **Install `yadm`**:

   ```bash
   sudo pacman -S yadm
   ```

2. **Clone the repository using `yadm`**:

   ```bash
   yadm clone https://github.com/Z-xus/dots.git
   ```

   This will create a bare Git repository in your home directory and automatically set up your dotfiles.

3. **Verify and Update**:

   If you need to update your dotfiles or pull the latest changes, you can use:

   ```bash
   yadm pull
   ```

## Tools & Configurations

### Zsh & Plugins

- **Powerlevel10k**: A fast and customizable Zsh theme.
- **Zinit**: Plugin manager for Zsh.
- Custom Zsh plugins for enhanced terminal functionality.

### Neovim

- **Lazy**: Plugin manager for Neovim.
- Configured for TypeScript, Python, and web development.
- Tailored keybindings and custom functions.

### i3 Window Manager

- A minimalist, keyboard-driven tiling window manager.
- Custom keybindings, status bar, and workspace management.

### Others

- **Wezterm**: Configured terminal emulator.
- **Tmux**: Session management with custom configurations.
- **Git**: Custom aliases and configurations for streamlined version control.

## Customization

Feel free to customize these dotfiles to fit your own workflow. The configurations are modular and can be easily adjusted or extended.

## Credits

- [Arch Linux](https://archlinux.org)
- [Zsh](https://www.zsh.org/)
- [Neovim](https://neovim.io/)
- [i3 Window Manager](https://i3wm.org/)
- All the amazing open-source projects and contributors whose work is utilized in these configurations.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

