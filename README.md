## Introduction

A Standard snake game with settings that I thought would make the game more fun.

## Table of Contents
1. [Installation](#installation)
2. [Game Rules](#rules)
3. [Controls](#controls)
4. [Game](#game)
5. [Contribution](#contribution)

## Installation

Run the game locally using LÖVE (https://love2d.org). Supported platforms: macOS, Windows, Linux.

Prerequisites
- Git (to clone the repo)
- LÖVE 11.3+ (or the latest stable release)

Quick start (common)
1. Clone the repository:

   ```sh
   git clone https://github.com/your-username/snake.git
   cd snake
   ```

2. Run with LÖVE from the project root:

   ```sh
   love .
   ```

Platform-specific notes

macOS
- Install via Homebrew (recommended):

  ```sh
  brew install --cask love
  ```

- Or download the .dmg from https://love2d.org and install normally.
- Run the game using the `love .` command from the project folder, or right-click the project folder and "Open With" → LÖVE.app.

Windows
- Recommended: download the latest Windows build from https://love2d.org and run the installer.
- If you use Chocolatey (choco):

  ```powershell
  choco install love
  ```

- To run: open a Command Prompt in the project folder and run `"C:\Program Files\LOVE\love.exe" .` (path depends on your installation). You can also create a .bat file that runs `love.exe` with the project path.

Linux
- Many distributions provide LÖVE packages. On Debian/Ubuntu you can try:

  ```sh
  sudo apt install love
  ```

- If the packaged version is old, use Flatpak (recommended) or the official packages from the LÖVE website. Flatpak example:

  ```sh
  flatpak install flathub org.love2d.Love
  flatpak run org.love2d.Love
  ```

Troubleshooting
- If `love` is not found on the PATH, check your installation or run the full path to the executable.
- If assets don't load, ensure you run `love .` from the repository root where main.lua is located.
## Rules
- Eating food makes the snake grow.
- When food is eaten it moves to another random place.
- Snake wraps around the screen (optional).
- Game over when snake hits itself (or the wall).

## Controls 
1. Arrow keys
2. wasd
3. hjkl

These controls work everywhere in the game (start screen, settings, game)

## Start-screen
The game starts with a start screen for navigating to other screens.

![start screen](public/start.png)

## Game

![game screen](public/game.png)

![highscore screen](public/highscore.png)

![setting screen](public/settings.png)

- wrap snake(on/off) - touching the edges doesn't kill the snake
- speed of game90-100) - it works in reverse, lower to speed here to make the game fast
- shape of game (sharp/rounded) - Shape of the menus, snake, food
- theme
    - default
    - rose-pine
    - catppuccin mocha
    - gruvbox dark
    - solarized dark
    - tokyo night
    - cyberpunk
    - one dark
    - nord
    - kangawa
- enable sound (eat food/ snake die) - put your computer's speakers to full volume because you would like to hear these sounds more.
[rules](#rules)

## Contribution

Thanks for helping improve this project — contributions are welcome!

Getting started
- Fork the repository and create a feature branch from `main`:

  ```sh
  git checkout -b feat/my-change
  ```

- Run the game locally with LÖVE while you develop:

  ```sh
  love .
  ```

Workflow and pull requests
- Keep changes small and focused; one logical change per PR.
- Write a short descriptive title and a 1–3 sentence PR body explaining the Why (not only the What).
- Target the `main` branch. If your change is large, open a draft PR early to get feedback.

Code style
- This project uses Lua (LÖVE). Follow these simple conventions:
  - Use 2 spaces for indentation.
  - Name global modules with PascalCase and local variables with camelCase.
  - Keep functions small and focused.

Testing
- There are no formal automated tests in the repository at the moment. When adding features, include manual verification steps in your PR description:
  - What you tested (platforms, configurations)
  - How to reproduce

Reporting bugs and feature requests
- Open an issue and include:
  - A short descriptive title
  - Steps to reproduce
  - Expected vs actual behavior
  - LÖVE version and OS (macOS/Windows/Linux)
  - Any relevant logs or screenshots

Commit messages
- Keep messages concise. Use the imperative present tense, for example:

  ```txt
  add: high-score screen
  fix: snake movement wrap-around edge case
  ```

Code of Conduct
- Be respectful and collaborative. If you'd like a formal code of conduct added, open an issue and we can add one.

License
- By contributing you agree that your contributions will be made under the project's existing license.

Thank you for contributing — I appreciate your time and ideas!
