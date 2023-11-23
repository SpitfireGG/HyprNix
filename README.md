<h1 align='center'> ✨ Dotfyles<h1>
<p align="center">
    my configuration files for Hyprland and stuffs<br><br>
    <img src="https://raw.githubusercontent.com/SpitfireGG/HyprNix/main/ewwwww/terminal.png", alt = "wtf">
    <img src="https://raw.githubusercontent.com/SpitfireGG/HyprNix/main/ewwwww/swappy.png", alt = "wtf">
</p>

## Showcase



<details>
    <summary><p>
    📸 Screenshots
    </p></summary>
    <p>
        <img src="https://raw.githubusercontent.com/SpitfireGG/HyprNix/main/ewwwww/btop.png", alt="picture of hyprland and nvim config">
        <img src="https://raw.githubusercontent.com/SpitfireGG/HyprNix/main/ewwwww/firefox.png", alt="same">
    </p>
</details>

## Config Tree Hyprland

```
├── hyprland.conf
├── main.nix
├── scripts
│   ├── screenshot.sh
│   └── volumecontrol.sh
├── walls
└── xdg-portal-hyprland
```

## Config Tree Nvim

```
├── init.lua
├── lazy-lock.json
└── lua
    ├── plugins
    │   ├── configs
    │   │   ├── alpha.lua
    │   │   ├── autopairs.lua
    │   │   ├── bufferline.lua
    │   │   ├── colorize.lua
    │   │   ├── comment.lua
    │   │   ├── debugging
    │   │   │   └── go.lua
    │   │   ├── devdocs.lua
    │   │   ├── diagflow.lua
    │   │   ├── disabled
    │   │   │   ├── auto-session.lua
    │   │   │   ├── block.lua
    │   │   │   ├── dropbar.lua
    │   │   │   ├── FuckerGPT.lua
    │   │   │   └── hardtime.lua
    │   │   ├── dressing.lua
    │   │   ├── gitlinker.lua
    │   │   ├── gitsigns.lua
    │   │   ├── harpoon.lua
    │   │   ├── hop.lua
    │   │   ├── hyper.lua
    │   │   ├── icons.lua
    │   │   ├── keymaps.lua
    │   │   ├── lsp
    │   │   │   ├── cmp.lua
    │   │   │   ├── conform.lua
    │   │   │   ├── lspconfig.lua
    │   │   │   ├── lspsaga.lua
    │   │   │   ├── luasnip.lua
    │   │   │   ├── mason.lua
    │   │   │   ├── nullus
    │   │   │   └── omnisharp.lua
    │   │   ├── lualine.lua
    │   │   ├── matchup.lua
    │   │   ├── navic.lua
    │   │   ├── neoscroll.lua
    │   │   ├── neo-tree.lua
    │   │   ├── notify.lua
    │   │   ├── nvim-webdev-icons.lua
    │   │   ├── oil.lua
    │   │   ├── personalDevelopmentEnv
    │   │   │   ├── clang.lua
    │   │   │   ├── css-intel.lua
    │   │   │   ├── neodev.lua
    │   │   │   ├── neotest.lua
    │   │   │   └── rust-tools.lua
    │   │   ├── regexer.lua
    │   │   ├── spectre.lua
    │   │   ├── surround.lua
    │   │   ├── telescope.lua
    │   │   ├── todo-comments.lua
    │   │   ├── toggle-term.lua
    │   │   ├── treesitter.lua
    │   │   ├── ufo.lua
    │   │   └── whichkey.lua
    │   └── init.lua
    ├── ui
    │   ├── config.lua
    │   ├── icons.lua
    │   ├── init.lua
    │   ├── lsp.lua
    │   ├── renamer.lua
    │   └── signature.lua
    └── user
        ├── bfs
        │   ├── config.lua
        │   ├── init.lua
        │   ├── keymaps.lua
        │   ├── split.lua
        │   └── utils.lua
        ├── colorscheme.lua
        ├── functions.lua
        ├── globals.lua
        ├── keymaps.lua
        ├── lazy.lua
        └── options.lua
```

## Installation:

~~Hyprland~~

<b> Caution ⚡ </b><br>
<p>If you want the whole hyprland configuration and make something as mine</p>

```shell
mv ~/.config ~/.config_bak
git clone https://github.com/SpitfireGG/HyprNix.git
cd HyprNix; mv cfg .config; cp -r .config ~/.config
```

<p>Or just [ cp -r <file/dir> <path> ] files and folders you want to copy </p>

~~Nvim~~

```shell
mv ~/.config/nvim/ ~/.config/nvim_bak
git clone https://github.com/SpitfireGG/HyprNix.git; cd HyprNix ;  mv nvim ~/.config/
```
## :TODO
- Fix GTK theming 
- Csharp lsp not configured properly
- Recheck the nvim config cause it's been faulty lately
- 1 star for this shit  ass config


## Credit

- i learned hyprland and nvim by modifying others config ,gradually got okay with hyprland and nvim
- the nvim is a a modified config from the owner of the original one
- thanks to the original owners :)
