# Neovim Configuration

This is my personal neovim configuration. It has a long way to become a perfect configuration but it is good enough for me to work with. I have been using this configuration for a while now and I am pretty happy with it. I have tried to keep it as minimal as possible and also tried to keep it as simple as possible. I have used `Lua` as the primary language for configuration.

## Installation
I am prettry sure if you are reading this you already know how to install neovim and also I don't think that I need to put emphasis on having a little or firm understanding of `Lua`.

> [!NOTE]
> I am using _Windows_ as my primary OS (Without WSL)

Setting up some plugins when on _windows_ is not less than a nightmare, one such example is using `treesitter`. Just use `zig` instead of a `c/c++` compiler and you will know what I am talking about.

### Prerequisites
- Make sure you have `neovim` installed on your system.
    ```bash
    winget install Neovim.Neovim
    ```
- In order to make your code look better in the terminal you should have [Nerd-Fonts](https://www.nerdfonts.com/font-downloads) installed, I recommend [Intone Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IntelOneMono.zip).
- Make sure you have `NodeJs` installed on your system.
    ```bash
    winget install OpenJS.NodeJS.LTS
    ```
- One of the plugin I use needs `bun.io` to be installed on your system. You can install it using 
    ```bash
    npm install -g bun.io
    ```
    - If the above command doesn't works, make sure you run the following command on **powershell**. 
        ```bash
        powershell -c "irm bun.sh/install.ps1 | iex"
        ```
- If you are on windows make sure to have `zig` installed on you PC.
    ```bash
    winget install -e --id zig.zig
    ```

#### Terminal Specifics
You also need to have [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file) and [ripgrep](https://github.com/BurntSushi/ripgrep) installed on your system, if you don't have, run the following commands.
```bash
winget install BurntSushi.ripgrep.MSVC
```

```bash
winget install fzf
```

### Cloning
> [!IMPORTANT]
> Clone this repository to your `C:/Users/<username>/AppData/Local` directory.

```bash
git clone https://github.com/ihnaqi/Neovim.git nvim
```
### Using Docker Instead
You can build and run it using docker as well, just run the following commands.

```bash
docker build -t neovim .
```

```bash
docker run -it neovim
```

### Terminal Background

It feels better when I see this little guy in the background of my terminal. You can use the following image as your terminal background as well.

![](./Mickey_Mouse_Disney_1.jpeg)
