<h1 align='center'> ✨ Dotfyles<h1>
<p align="center">
    my configuration files for Hyprland and stuffs<br><br>
    <img src="https://github.com/SpitfireGG/HyprNix/blob/main/assets/wall.png">
</p>

## Showcase

<details>
    <summary><p>
    📸 Screenshots
    </p></summary>
    <p>
        <img src="https://github.com/SpitfireGG/HyprNix/blob/main/assets/one.png", alt="picture of hyprland and nvim config">
        <img src="https://github.com/SpitfireGG/HyprNix/blob/main/assets/two.png", alt="same">
    </p>
</details>

## Config Tree Hyprland

```
├── bak_hyprland.conf
├── cuc
├── hyprland.conf
├── main.nix
├── scripts
│   ├── screenshot.sh
│   └── volumecontrol.sh
├── walls
└── xdg-portal-hyprland

3 directories, 7 files
```

## Config Tree Nvim

```
├── init.lua
├── lazy-lock.json
├── lua
│   ├── plugins
│   │   ├── configs
│   │   │   ├── alpha.lua
│   │   │   ├── autopairs.lua
│   │   │   ├── bookmark.lua
│   │   │   ├── bufferline.lua
│   │   │   ├── cmp.lua
│   │   │   ├── colorize.lua
│   │   │   ├── comment.lua
│   │   │   ├── dressing.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   ├── harpoon.lua
│   │   │   ├── icons.lua
│   │   │   ├── keymaps.lua
│   │   │   ├── lsp
│   │   │   │   ├── lspconfig.lua
│   │   │   │   ├── lspsaga.lua
│   │   │   │   ├── mason.lua
│   │   │   │   └── null-ls.lua
│   │   │   ├── lualine.lua
│   │   │   ├── matchup.lua
│   │   │   ├── navic.lua
│   │   │   ├── neoscroll.lua
│   │   │   ├── neo-tree.lua
│   │   │   ├── notify.lua
│   │   │   ├── nvim-webdev-icons.lua
│   │   │   ├── project.lua
│   │   │   ├── rust-tools.lua
│   │   │   ├── spectre.lua
│   │   │   ├── surround.lua
│   │   │   ├── telescope.lua
│   │   │   ├── todo-comments.lua
│   │   │   ├── toggle-term.lua
│   │   │   ├── treesitter.lua
│   │   │   └── whichkey.lua
│   │   └── init.lua
│   ├── ui
│   │   ├── config.lua
│   │   ├── icons.lua
│   │   ├── init.lua
│   │   ├── lsp.lua
│   │   ├── renamer.lua
│   │   └── signature.lua
│   └── user
│       ├── colorscheme.lua
│       ├── functions.lua
│       ├── globals.lua
│       ├── kenzo
│       │   ├── config.lua
│       │   ├── init.lua
│       │   ├── keymaps.lua
│       │   ├── split.lua
│       │   └── utils.lua
│       ├── keymaps.lua
│       ├── lazy.lua
│       └── options.lua
└── README.md

8 directories, 54 files
```

## Installation:

```shell

Hyprland

**Note:** Caution

 in case that you want to get the whole config dir and make something as mine

mv ~/.config ~/.config_bak
git clone https://github.com/SpitfireGG/HyprNix.git
cd HyprNix; mv cfg .config; cp -r .config ~/.config

else just [cp -r <file/dir> <path>] files and folders you want to copy

Nvim

mv ~/.config/nvim/ ~/.config/nvim_bak
git clone https://github.com/SpitfireGG/HyprNix.git; cd HyprNix ;  mv nvim ~/.config/
```

## Credits:

- i learned hyprland and nvim by modifying others config ,gradually got okay with hyprland and nvim
- the nvim is a a modified config from the owner of the original one
- thanks to the original owners :)
