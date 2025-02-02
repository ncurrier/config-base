# Enhanced Zsh Environment Setup

This repository provides an installation script that sets up a modern and feature-rich Zsh environment. This setup installs a variety of command-line utilities and plugins designed to boost your productivity and streamline your workflow in the terminal. Below you will find detailed descriptions of every component included in this setup.

## Overview

The installation script configures the following components:

1. **Directory Navigation & Fuzzy Finding**
   - **zoxide:**  
     A smart directory jumping tool that learns your most frequented directories. Instead of typing out long paths, simply type `j <partial-directory-name>` to quickly jump to your desired location.
   - **fzf:**  
     A general-purpose fuzzy finder that lets you search through files, directories, and even your command history using an interactive interface.

2. **Enhanced Listing & File Viewing**
   - **eza:**  
     A modern replacement for the `ls` command. It displays files and directories with colorful, formatted output, icons, and groups directories first, making listings easier to read.
   - **bat:**  
     An enhanced alternative to `cat` that provides syntax highlighting, Git integration, and improved formatting for viewing file contents.

3. **Searching & Data Processing**
   - **fd:**  
     A simple, fast, and user-friendly alternative to the traditional Unix `find` command. It uses sensible defaults and an intuitive syntax to quickly locate files.
   - **ripgrep (rg):**  
     A powerful, line-oriented search tool that recursively searches your files for a regex pattern—much faster than the classic grep.
   - **jq & yq:**  
     Command-line processors for JSON and YAML data, respectively. These tools help you parse, filter, and transform structured data from the command line.

4. **Git & GitHub Integration**
   - **lazygit:**  
     An interactive terminal user interface for Git. It provides a visual way to manage branches, commits, and repositories without leaving the terminal.
   - **gh:**  
     The official GitHub command-line tool that lets you manage issues, pull requests, and perform other GitHub tasks directly from your shell.
   - **git-delta:**  
     A syntax-highlighting pager for Git diffs. It improves the readability of code changes by highlighting differences in a visually appealing manner.

5. **System Monitoring & Benchmarking**
   - **htop:**  
     An interactive process viewer that displays system processes and resource usage in real-time.
   - **ncdu:**  
     A disk usage analyzer with an intuitive text-based interface, ideal for identifying files or directories that consume excessive space.
   - **procs:**  
     A modern alternative to the `ps` command, providing a more user-friendly and informative view of running processes.
   - **duf:**  
     A disk usage utility that presents filesystem usage in a clear, organized format.
   - **neofetch:**  
     A tool that displays system information (such as OS, kernel, uptime, etc.) in an aesthetically pleasing format.
   - **hyperfine:**  
     A benchmarking tool to measure and compare the performance of different commands.

6. **HTTP & API Testing**
   - **httpie:**  
     A user-friendly HTTP client designed for testing and interacting with web APIs. It offers a simpler syntax and more readable output compared to curl.

7. **Environment Management & Automation**
   - **entr:**  
     A utility that runs specified commands whenever files change. It is particularly useful for automating tasks like running tests or rebuilding projects.
   - **direnv:**  
     A tool that automatically loads and unloads environment variables as you navigate into or out of directories, making project-specific environment management seamless.

8. **Terminal Multiplexing & Customization**
   - **tmux:**  
     A terminal multiplexer that allows you to manage multiple terminal sessions within a single window. It supports splitting windows, session management, and more.
   - **starship:**  
     A fast, highly customizable prompt that displays useful information at a glance. It is designed to work with any shell and can be tailored through its configuration file.

9. **History Management**
   - **hstr:**  
     An interactive history search tool that lets you browse and reuse previous commands efficiently. It is especially useful when you need to recall complex commands from your history.

10. **GNU Tools (on macOS)**
    - **coreutils & moreutils:**  
      These packages provide additional GNU utilities that offer enhanced functionality compared to the default macOS tools.

11. **Zsh Plugins**
    - **zsh-autosuggestions:**  
      A plugin that suggests commands based on your history as you type, helping you complete commands faster.
    - **zsh-syntax-highlighting:**  
      A plugin that highlights commands and syntax in real-time as you type, which can help prevent errors.

## Installation

To install and configure your enhanced Zsh environment, simply run the provided installation script:

```bash
./setup.sh
```

The installation script will:
- Install Homebrew (if not already installed) and update it.
- Install all the necessary command-line utilities and Zsh plugins.
- Set up fzf key bindings and auto-completion.
- Update your `~/.zshrc` file with custom aliases, plugin initializations, and keybindings.
- Optionally change your default shell to Zsh if it is not already set.

After the installation is complete, restart your terminal or run the following command to start using the new configuration immediately:

```bash
exec zsh
```

## Keybindings

This environment comes with several useful keybindings that enhance productivity:

- **Ctrl+T**: Open a file selection menu.
- **Ctrl+R**: Search command history using fzf.
- **Alt+C**: Change directories interactively using fzf.  (map option keys to ESC+ Meta keys in your terminal for this to work)
- **j <dir>**: Use zoxide to jump to frequently visited directories.
- **hstr**: Open hstr for searching command history.

## Resources & Documentation

For additional information about the tools included in this setup, refer to their respective documentation:

- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)
- [bat](https://github.com/sharkdp/bat)
- [eza](https://github.com/eza-community/eza)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [gh](https://cli.github.com/)
- [git-delta](https://github.com/dandavison/delta)
- [htop](https://github.com/htop-dev/htop)
- [ncdu](https://dev.yorhel.nl/ncdu)
- [procs](https://github.com/dalance/procs)
- [duf](https://github.com/muesli/duf)
- [httpie](https://github.com/httpie/httpie)
- [starship](https://github.com/starship/starship)
- [tmux](https://github.com/tmux/tmux)
- [jq](https://stedolan.github.io/jq/)
- [yq](https://github.com/mikefarah/yq)
- [entr](http://entrproject.org)
- [direnv](https://github.com/direnv/direnv)
- [neofetch](https://github.com/dylanaraps/neofetch)
- [hyperfine](https://github.com/sharkdp/hyperfine)
- [broot](https://github.com/Canop/broot)
- [hstr](https://github.com/dvorka/hstr)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
