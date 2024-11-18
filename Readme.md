# Neovim Configuration

This is my personal neovim configuration. It is a work in progress and will be updated as I tweek around cool stuffs in my journey towards the _vim land_.

## Installation
I am prettry sure if you are reading this you already know how to install neovim and also I don't think that I need to put emphasis on having a little or firm understanding of `Lua`.

> [!NOTE]
> I am using _Windows_ as my primary OS (Without WSL)

Setting up some plugins when on _windows_ is not less than a nightmare, one such example is using `treesitter`. Just use `zig` instead of a `c/c++` compiler and you will know what I am talking about.

### Prerequisites
- Make sure you have `NodeJs` installed on your system.
- One of the plugin I use needs `bun.io` to be installed on your system. You can install it using `npm install -g bun.io`.
- If you are on windows make sure to have `zig` installed on you PC.

### Using Docker Instead
You can build and run it using docker as well, just run the following commands.

```bash
docker build -t neovim .
```

```bash
docker run -it neovim
```

<img src="Mickey_Mouse_Disney_1.jpeg" alt="Mickey Mouse" width="200" height="300">
