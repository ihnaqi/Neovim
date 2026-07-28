# Neovim Configuration

A modular Neovim setup built on [lazy.nvim](https://github.com/folke/lazy.nvim), with LSP via
[mason](https://github.com/mason-org/mason.nvim), completion via
[blink.cmp](https://github.com/saghen/blink.cmp), Treesitter (`main` branch), the
[snacks.nvim](https://github.com/folke/snacks.nvim) picker/explorer suite, Harpoon, VimTeX, and a
transparent OneDark theme.

- **Leader:** `<Space>`
- **Local leader:** `\`
- **Plugin manager:** lazy.nvim (bootstraps itself on first launch)
- **Plugins:** 29, version-pinned in `lazy-lock.json`

---

## Table of Contents

1. [Requirements](#requirements)
   — [Linux / macOS](#install-the-prerequisites--linux--macos) · [Windows](#install-the-prerequisites--windows-native)
2. [Installation](#installation)
3. [First Launch](#first-launch)
4. [Directory Layout](#directory-layout)
5. [Plugins](#plugins)
6. [Language Servers](#language-servers)
7. [Keymaps](#keymaps)
8. [Editor Options](#editor-options)
9. [Troubleshooting](#troubleshooting)

---

## Requirements

### Core (mandatory)

| Tool | Minimum | Why it is needed |
|------|---------|------------------|
| **Neovim** | **0.12.0+** | This config pins `nvim-treesitter`'s `main` branch, whose health check hard-errors below 0.12 (`Nvim-treesitter requires Neovim 0.12.0 or later`). It also uses the `vim.lsp.config()` API. Neovim must be linked against tree-sitter ABI ≥ 13 — official builds are. |
| **git** | 2.19+ | lazy.nvim bootstraps and clones every plugin with `--filter=blob:none` (partial clone). |
| **`tree-sitter` CLI** | **0.26.1+** | The `main` branch shells out to `tree-sitter build` for every parser. Not optional — no CLI, no syntax highlighting. |
| **C compiler** | any recent | `tree-sitter build` invokes it to compile each parser. `gcc`/`clang` on Linux/macOS, `zig` or MSVC on Windows. |
| **curl** and **tar** | any | Treesitter downloads and unpacks grammar tarballs with these; Mason uses them too. |
| **unzip**, **gzip** | any | Mason unpacks some release archives with these. |
| **A Nerd Font** | v3.x | Icons in lualine, blink.cmp, snacks, the file explorer and the floating terminal. Without one you get tofu boxes. |
| **A true-color terminal** | — | `termguicolors` is on and the theme is transparent. kitty, WezTerm, Alacritty, Ghostty, foot, or Windows Terminal. |

### Strongly recommended

| Tool | Used by | Notes |
|------|---------|-------|
| **ripgrep** (`rg`) | `snacks.picker` grep | `<leader>fg` (workspace grep) is effectively non-functional without it. |
| **fd** (`fd` / `fdfind`) | `snacks.picker` files | Much faster file listing. Debian/Ubuntu ship the binary as `fdfind`; snacks detects both names. |
| **lazygit** | `lazygit.nvim` | `<leader>lg` opens it in a float. The plugin is a wrapper only — the binary must be on `$PATH`. |
| **Node.js + npm** | Mason | Required to install `ts_ls`, `astro`, `html`, `cssls`, `jsonls` (all npm packages). |
| **Clipboard provider** | `clipboard=unnamedplus` | Linux only: `wl-clipboard` on Wayland, `xclip` or `xsel` on X11. Without one, yanks do not reach the system clipboard (Neovim can fall back to OSC 52 over SSH). macOS and Windows work out of the box. |

### Optional (per feature)

| Feature | Requires |
|---------|----------|
| **LaTeX** (`vimtex`, `texlab`) | A TeX distribution (TeX Live / MacTeX / MiKTeX), `latexmk`, and **zathura** as the PDF viewer — `vimtex_view_method` is hard-set to `zathura` in `lua/plugins/vimlatex.lua`. Windows has no zathura; see the [Windows section](#5-latex-only-if-you-use-it). |
| **tmux navigation** | `tmux`, plus the matching [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) bindings in your `~/.tmux.conf`. Windows users should [remove this plugin](#4-remove-the-tmux-plugin). |
| **Rust LSP** (`rust_analyzer`) | Mason downloads the binary; a `rustup`/`cargo` toolchain is still needed for it to analyse projects usefully. |
| **Python 3 + pip** | Only if you later add Python-based Mason packages. |

### Install the prerequisites — Linux / macOS

**Debian / Ubuntu**

```bash
sudo apt update
sudo apt install -y git build-essential curl unzip tar gzip \
                    ripgrep fd-find lazygit tmux \
                    xclip wl-clipboard \
                    nodejs npm python3 python3-pip
npm install -g tree-sitter-cli        # distro package is usually too old
# Optional, for LaTeX:
sudo apt install -y texlive-latex-extra latexmk zathura
```

> Ubuntu's Neovim package is usually too old for the required 0.12. Install a current build from the
> [official release page](https://github.com/neovim/neovim/releases), or via `snap install nvim --classic`.
> `fd` is installed as `fdfind`; symlink it if you want the short name:
> `ln -s $(which fdfind) ~/.local/bin/fd`

**Arch Linux**

```bash
sudo pacman -S --needed neovim git base-devel curl unzip tar gzip \
                        tree-sitter-cli ripgrep fd lazygit tmux \
                        wl-clipboard xclip nodejs npm python python-pip
# Optional, for LaTeX:
sudo pacman -S texlive-latexextra texlive-binextra zathura zathura-pdf-mupdf
```

**Fedora**

```bash
sudo dnf install -y neovim git gcc make curl unzip tar gzip \
                    ripgrep fd-find lazygit tmux wl-clipboard xclip \
                    nodejs npm python3 python3-pip
npm install -g tree-sitter-cli
```

**macOS (Homebrew)**

```bash
brew install neovim git curl tree-sitter ripgrep fd lazygit tmux node python
brew install --cask font-jetbrains-mono-nerd-font
# Optional, for LaTeX:
brew install --cask mactex zathura
```

**Nerd Font** — pick any from [nerdfonts.com](https://www.nerdfonts.com/font-downloads)
(JetBrainsMono, FiraCode, Hack are common choices) and set it as your terminal font.

Verify the CLI version afterwards — 0.26.1 is the floor:

```bash
tree-sitter --version
```

---

### Install the prerequisites — Windows (native)

Everything below is native Windows. No WSL, no MSYS2 shell required.

#### 1. Packages

**winget** (built into Windows 11 / recent Windows 10):

```powershell
winget install --id Neovim.Neovim -e
winget install --id Git.Git -e
winget install --id zig.zig -e                      # C compiler for tree-sitter
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id sharkdp.fd -e
winget install --id JesseDuffield.lazygit -e
winget install --id OpenJS.NodeJS.LTS -e
npm install -g tree-sitter-cli                      # required by nvim-treesitter
```

**scoop** (nicer if you want the Nerd Font from a package too):

```powershell
scoop install main/neovim main/git main/zig main/ripgrep main/fd main/lazygit main/nodejs-lts
npm install -g tree-sitter-cli
scoop bucket add nerd-fonts
scoop install nerd-fonts/JetBrainsMono-NF
```

Package IDs drift — if one fails, find the current one with `winget search <name>` or
`scoop search <name>`. Restart the terminal afterwards so `PATH` updates.

`curl.exe` and `tar.exe` ship with Windows 10 1803+ in `System32`, so those two boxes are already
ticked. The clipboard also works out of the box — Neovim talks to the Win32 clipboard directly,
so `clipboard=unnamedplus` needs no helper program (no `win32yank`; that is a WSL workaround).

#### 2. The C compiler — use zig

`tree-sitter build` needs a C compiler. On Windows, **zig** is the path of least resistance: one
self-contained download, no Visual Studio, no `vcvarsall` dance, and it works from an ordinary
PowerShell session.

If a parser build fails with a "no compiler found"-style error, point the toolchain at zig by
putting a `cc.cmd` shim somewhere on your `PATH`:

```bat
@echo off
zig cc %*
```

The alternatives, if you prefer them:

- **MSVC** — install "Desktop development with C++" from the
  [Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/). `cl.exe` is only on
  `PATH` inside a *Developer PowerShell for VS*, so you must launch Neovim from that shell for
  parser installs to work.
- **LLVM/clang** — `winget install --id LLVM.LLVM -e`, which puts `clang.exe` on `PATH` globally.

#### 3. Where the config goes

Windows does not use `~/.config`:

| Purpose | Path |
|---------|------|
| Config (this repo) | `%LOCALAPPDATA%\nvim` → `C:\Users\<you>\AppData\Local\nvim` |
| Plugins & Mason data | `%LOCALAPPDATA%\nvim-data` |

```powershell
git clone <this-repo-url> $env:LOCALAPPDATA\nvim
nvim
```

#### 4. Remove the tmux plugin

`vim-tmux-navigator` is pointless without tmux, and its `<C-h/j/k/l>` maps would shadow the plain
window-navigation maps. Delete the spec:

```powershell
Remove-Item $env:LOCALAPPDATA\nvim\lua\plugins\vimtmuxnav.lua
```

Nothing else needs touching — `lua/core/keymaps.lua` already maps `<C-h/j/k/l>` to `:wincmd h/j/k/l`,
so split navigation keeps working exactly as before. Also drop `vim-tmux-navigator` from
`lazy-lock.json`, or just run `:Lazy clean` once inside Neovim.

#### 5. LaTeX (only if you use it)

`zathura` has no Windows build. Use **SumatraPDF**, which supports forward search:

```powershell
winget install --id MiKTeX.MiKTeX -e            # or TeXLive.TeXLive
winget install --id SumatraPDF.SumatraPDF -e
```

Then replace the `init` block in `lua/plugins/vimlatex.lua`:

```lua
init = function()
  vim.g.vimtex_view_method = "general"
  vim.g.vimtex_view_general_viewer = "SumatraPDF"
  vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
end,
```

Make sure `SumatraPDF.exe` is on `PATH` (winget's install location usually is; otherwise give the
full path).

#### 6. Optional: use PowerShell for `:terminal`

`<leader>tt` spawns `vim.o.shell`, which is `cmd.exe` by default. To get PowerShell instead, add
this to `lua/core/options.lua`:

```lua
if vim.fn.has("win32") == 1 then
  vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  vim.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
```

#### 7. Terminal emulator

Use **Windows Terminal**, **WezTerm**, or **Alacritty** — all support true colour, which
`termguicolors` and the transparent theme require. `conhost.exe` (the old console window) does not
render this config correctly. Set the Nerd Font in the terminal's profile settings, not in Neovim.

**Windows Terminal is the recommendation.** It ships with the OS, and its per-profile background
image needs no extra dependency — which this config is built to exploit: `onedarkpro` runs with
`transparency = true` and `lua/core/options.lua` clears the background on `Normal`, `NormalFloat`,
`FloatBorder`, `Pmenu` and `EndOfBuffer`, so the image shows through the editor, the floating
terminal, the pickers and the completion menu rather than being covered by an opaque slab. Set it
per profile in `settings.json`:

```jsonc
{
  "backgroundImage": "C:\\Users\\<you>\\Pictures\\bg.png",
  "backgroundImageOpacity": 0.25,   // keep it low -- text contrast dies fast above ~0.4
  "backgroundImageStretchMode": "uniformToFill"
}
```

If you ever want an opaque background instead, set `transparency = false` in
`lua/plugins/colorscheme.lua`; the `<leader>bg` mapping re-applies the colourscheme.

#### Windows caveats worth knowing

- **Mason**: most servers in this config install fine, but Mason on Windows occasionally lacks a
  package that exists on Linux. Run `:checkhealth mason` and install whatever it flags.
- **Long paths**: deeply nested npm packages under Mason can exceed the 260-character limit. Enable
  long paths once, from an admin PowerShell:
  `New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name LongPathsEnabled -Value 1 -PropertyType DWORD -Force`
- **Antivirus**: Defender scanning `%LOCALAPPDATA%\nvim-data` noticeably slows plugin updates and
  parser builds. Excluding that folder is a large, safe win.
- **`git config --global core.autocrlf`**: leave it at `input`/`false` for this repo. CRLF in Lua
  files is harmless, but it makes diffs noisy if you share the config across machines.

---

## Installation

**Linux / macOS**

```bash
# Back up any existing config and state
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Install this config
git clone <this-repo-url> ~/.config/nvim

nvim
```

**Windows (PowerShell)**

```powershell
# Back up any existing config and state
Move-Item $env:LOCALAPPDATA\nvim      $env:LOCALAPPDATA\nvim.bak      -ErrorAction SilentlyContinue
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak -ErrorAction SilentlyContinue

# Install this config
git clone <this-repo-url> $env:LOCALAPPDATA\nvim

# Then remove the tmux plugin -- see the Windows section
Remove-Item $env:LOCALAPPDATA\nvim\lua\plugins\vimtmuxnav.lua

nvim
```

---

## First Launch

On the first start, in order:

1. `lua/config/lazy.lua` clones lazy.nvim into `~/.local/share/nvim/lazy/lazy.nvim` if it is missing.
2. lazy.nvim installs all 29 plugins at the commits pinned in `lazy-lock.json` (28 on Windows,
   after removing the tmux plugin).
3. `nvim-treesitter` downloads and builds the parsers listed in `lua/plugins/treesitter.lua`
   (lua, javascript, typescript, tsx, rust, vim, vimdoc, latex, bibtex) via `tree-sitter build`.
4. `mason-lspconfig` installs the nine language servers listed under
   [Language Servers](#language-servers).

Expect a minute or two of compilation and downloads. Some transient errors are normal while
parsers are still building — restart Neovim once everything settles.

**Verify the setup:**

```vim
:checkhealth        " overall diagnosis — read the warnings
:Lazy               " plugin status
:Mason              " LSP/tool installer UI
:TSUpdate           " refresh Treesitter parsers
:LspInfo            " which servers are attached to the current buffer
```

---

## Directory Layout

Shown at the Unix path; on Windows the same tree lives in `%LOCALAPPDATA%\nvim`.

```
~/.config/nvim/
├── init.lua                 # leader keys, then loads core/ and config/
├── lazy-lock.json           # pinned plugin commits — commit this file
├── .luarc.json              # lua_ls settings for editing this config (see below)
├── lua/
│   ├── core/
│   │   ├── options.lua      # vim.opt settings, transparency highlights
│   │   └── keymaps.lua      # global keymaps, terminal autocmds, VimTeX filetype maps
│   ├── config/
│   │   └── lazy.lua         # lazy.nvim bootstrap + setup
│   └── plugins/             # one file per plugin (auto-imported by lazy.nvim)
│       ├── blink.lua         # completion
│       ├── colorscheme.lua   # onedarkpro
│       ├── gitsigns.lua      # git gutter + inline blame
│       ├── harpoon.lua       # file marks
│       ├── lazygit.lua       # lazygit float
│       ├── lsp.lua           # diagnostics config + LspAttach keymaps
│       ├── lualine.lua       # statusline
│       ├── markdownview.lua  # markdown rendering
│       ├── mason.lua         # LSP installer
│       ├── miscellaneous.lua # sleuth, autopairs, todo-comments, colorizer,
│       │                     # undotree, noice, surround
│       ├── snacks.lua        # picker, explorer, dashboard, zen, scroll…
│       ├── terminal.lua      # custom floating terminal (not a plugin)
│       ├── treesitter.lua    # parsers + per-buffer highlight/indent
│       ├── trouble.lua       # diagnostics list
│       ├── vimlatex.lua      # vimtex
│       └── vimtmuxnav.lua    # tmux pane navigation
└── README.md
```

Anything returning a plugin spec from `lua/plugins/` is picked up automatically — drop in a new
file to add a plugin. `terminal.lua` is plain configuration that returns an empty spec `{}` so
lazy.nvim ignores it.

---

## Plugins

**UI & appearance**
- `olimorris/onedarkpro.nvim` — `onedark_dark` theme, transparency on
- `nvim-lualine/lualine.nvim` — statusline with branch, diff, diagnostics, cursor position, date/clock
- `folke/noice.nvim` + `MunifTanjim/nui.nvim` — replacement cmdline/messages UI
- `folke/snacks.nvim` — dashboard, picker, explorer, indent guides, notifier, zen mode, smooth scroll, bigfile handling
- `nvim-tree/nvim-web-devicons` — filetype icons
- `catgoose/nvim-colorizer.lua` — inline colour previews

**Editing**
- `saghen/blink.cmp` + `L3MON4D3/LuaSnip` + `rafamadriz/friendly-snippets` — completion & snippets
- `windwp/nvim-autopairs` — bracket/quote pairing
- `kylechui/nvim-surround` — surround text objects
- `tpope/vim-sleuth` — auto-detect indentation per file
- `mbbill/undotree` — persistent undo history browser
- `folke/todo-comments.nvim` — highlight TODO/FIXME/etc.

**LSP & syntax**
- `neovim/nvim-lspconfig` + `folke/lazydev.nvim` — LSP, with Lua/`vim.uv` types for config editing
- `mason-org/mason.nvim` + `mason-org/mason-lspconfig.nvim` — server installation
- `nvim-treesitter/nvim-treesitter` (`main` branch) — parsing, highlighting, indentation
- `folke/trouble.nvim` — diagnostics / symbols / references list

**Navigation & git**
- `ThePrimeagen/harpoon` (`harpoon2`) — pinned file marks
- `christoomey/vim-tmux-navigator` — seamless nvim ↔ tmux pane movement
- `lewis6991/gitsigns.nvim` — signs, hunks, current-line blame
- `kdheepak/lazygit.nvim` — lazygit in a floating window

**Writing**
- `lervag/vimtex` — LaTeX toolchain integration (zathura viewer)
- `OXY2DEV/markview.nvim` — in-buffer markdown rendering

---

## Language Servers

Installed automatically by `mason-lspconfig` (`lua/plugins/mason.lua`):

| Server | Language | Installed via |
|--------|----------|---------------|
| `lua_ls` | Lua | prebuilt binary |
| `ts_ls` | TypeScript / JavaScript | npm |
| `astro` | Astro | npm |
| `html` | HTML | npm |
| `cssls` | CSS | npm |
| `jsonls` | JSON | npm |
| `rust_analyzer` | Rust | prebuilt binary |
| `marksman` | Markdown | prebuilt binary |
| `texlab` | LaTeX | prebuilt binary |

`lua_ls` is additionally configured to recognise the `vim` global. To add a server, append its
name to `ensure_installed` in `lua/plugins/mason.lua` and restart.

**Format on save** is enabled in `lua/plugins/lsp.lua` for any attached server that supports
`textDocument/formatting` but not `textDocument/willSaveWaitUntil` (1s timeout).

### Editing this config

`.luarc.json` configures `lua_ls` for this directory, so editing the config itself is warning-free
in Neovim *and* in any external tool that runs `lua-language-server` (CI, other editors, the CLI
checker). It declares the LuaJIT runtime, the `vim` and `Snacks` globals, and puts
`$VIMRUNTIME/lua` plus the snacks type definitions on the workspace library path. Inside Neovim,
`lazydev.nvim` layers on top of this and loads plugin types on demand.

Check the whole config from a shell:

```bash
lua-language-server --check ~/.config/nvim --checklevel=Warning
```

---

## Keymaps

Leader is `<Space>`. Local leader is `\`.

### Files, search & pickers (snacks)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fh` | Find hidden / dot files |
| `<leader>fg` | Grep workspace |
| `<leader>fb` | Find buffers |
| `<leader>sk` | Search keymaps |
| `<leader>mk` | Search marks |
| `<leader>nh` | Notification history |
| `<leader>ee` | File explorer (left sidebar) |
| `<leader>pe` | Netrw `:Explore` |

Inside the explorer: `H` toggles hidden files, `I` toggles ignored files.

### Harpoon

| Key | Action |
|-----|--------|
| `<leader>a` | Add current file to list |
| `<leader>ls` | Toggle quick menu |
| `<C-t>` / `<C-y>` / `<C-n>` / `<C-s>` | Jump to file 1 / 2 / 3 / 4 |
| `<leader>pr` / `<leader>nt` | Previous / next in list |

### LSP (buffer-local, on attach)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `gr` | Show references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>vw` | Show line diagnostic in a float |

### Trouble

| Key | Action |
|-----|--------|
| `<leader>xx` | Diagnostics (workspace) |
| `<leader>xX` | Diagnostics (current buffer) |
| `<leader>cs` | Symbols |
| `<leader>cl` | LSP definitions / references |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |

### Splits & navigation

| Key | Action |
|-----|--------|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move between splits (and tmux panes, where tmux is used) |
| `<C-\>` | Previous tmux pane (tmux only) |
| `n` / `N` | Search next / previous, centred |
| `<leader>cc` | Centre cursor line |
| `<leader>lw` | Toggle line wrap |
| `<leader>fd` / `<leader>ud` | Fold to matching bracket / unfold |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle centred floating terminal (works from normal *and* terminal mode) |
| `<leader>st` | Open a 6-line horizontal terminal split |
| `:ToggleTerminal` | Same as `<leader>tt` |

### Git

| Key | Action |
|-----|--------|
| `<leader>lg` | Open LazyGit |

Current-line blame is shown as virtual text after a 1s delay.

### Misc

| Key | Action |
|-----|--------|
| `hhg` or `<C-g>` (insert) | Escape to normal mode |
| `<C-u>` | Toggle undotree |
| `<leader>z` / `<leader>Z` | Zen mode / Zen zoom |
| `<leader>bg` | Re-apply colourscheme (transparency toggle) |
| `<` / `>` (visual) | Indent and stay in visual mode |
| `<leader>cmp` / `<leader>cn` (`.tex` only) | VimTeX compile / clean |

---

## Editor Options

Set in `lua/core/options.lua`:

- Indentation: 3 spaces (`tabstop`, `shiftwidth`, `softtabstop`), `expandtab`
  — `vim-sleuth` overrides this per file when it detects a project style
- Numbers: absolute + relative
- `clipboard=unnamedplus` — shares the system clipboard
- `ignorecase` + `smartcase` search; `hlsearch` on
- No swapfiles; persistent undo (10,000 levels) in `~/.undodir` — resolved with `vim.fn.expand()`,
  so it lands in `C:\Users\<you>\.undodir` on Windows. Neovim creates the directory if it is missing.
- `laststatus=3` — a single global statusline
- `scrolloff=2`, no line wrap by default, `mouse=a`
- Transparent `Normal`, `NormalFloat`, `FloatBorder`, `Pmenu`, `EndOfBuffer`
- `j`/`k`/`$`/`^`/`_` remapped to their `g`-prefixed forms so they move by display line when wrap is on

---

## Troubleshooting

**Icons render as boxes or question marks** — your terminal font is not a Nerd Font. Install one
and select it in the terminal's settings, not in Neovim.

**`<leader>fg` finds nothing** — install `ripgrep`. The snacks grep picker shells out to `rg`.

**`<leader>lg` errors** — the `lazygit` binary is not on `$PATH`. The plugin does not bundle it.

**Treesitter errors on startup / no syntax highlighting** — run `:checkhealth nvim-treesitter`
first; it names the exact missing piece. The usual causes are a missing `tree-sitter` CLI, a CLI
older than 0.26.1, or no C compiler on `PATH`. On Windows, install zig (see above). This config
pins the `main` branch, whose API differs from the older `master` branch; do not copy `master`-era
snippets (`ensure_installed`, `highlight = { enable = true }`) into `lua/plugins/treesitter.lua`.

**A language server never attaches** — check in `:Mason` that it installed, then `:LspInfo` in a
buffer of that filetype. npm-based servers (`ts_ls`, `astro`, `html`, `cssls`, `jsonls`) fail to
install if Node.js is absent.

**Yanks do not reach the system clipboard** — install `wl-clipboard` (Wayland) or `xclip`/`xsel`
(X11), then confirm with `:checkhealth provider`.

**VimTeX cannot preview the PDF** — `zathura` is hardcoded as the viewer. Install it, or change
`vim.g.vimtex_view_method` in `lua/plugins/vimlatex.lua` (`skim` on macOS, `sioyek`, `general`, …).

**Transparency looks wrong** — the theme is transparent by design; the background comes from your
terminal. Set `transparency = false` in `lua/plugins/colorscheme.lua` for an opaque background.

**Something broke after an update** — `lazy-lock.json` pins every plugin. Restore it from git and
run `:Lazy restore` to roll all plugins back to the recorded commits.

**Start clean** — remove `~/.local/share/nvim`, `~/.local/state/nvim` and `~/.cache/nvim`
(`%LOCALAPPDATA%\nvim-data` on Windows), then relaunch. The config itself is untouched by this.

### Windows-specific

**`<C-h/j/k/l>` do nothing, or Neovim complains about `TmuxNavigateLeft`** — you did not delete
`lua/plugins/vimtmuxnav.lua`. Remove it and run `:Lazy clean`.

**`attempt to concatenate a nil value` on startup** — an older copy of this config used
`os.getenv("HOME")` for the undo directory, and `HOME` is not set by cmd or PowerShell. Current
versions use `vim.fn.expand("~/.undodir")`, which is correct on every platform; pull the latest.

**Parser builds fail but zig is installed** — the tree-sitter CLI looks for a compiler named `cc`
or `cl`, not `zig`. Add the `cc.cmd` shim shown above, or run Neovim from a Developer PowerShell
if you went the MSVC route.

**Icons are misaligned rather than missing** — Windows Terminal needs the Nerd Font set for the
specific *profile*, and "Use the terminal's built-in font fallback" can override it. Set the font
in the profile's Appearance tab.

**Mason installs fail with path errors** — enable long paths (see the Windows caveats above) and
confirm Node.js is on `PATH` for the npm-based servers.
