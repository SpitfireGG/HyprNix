set fish_greeting

jump shell fish | source

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.nix-profile/bin/ghc:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

set -x GOPATH $HOME/go
set -x PATH $PATH /usr/bin/cargo

set -x MANPAGER "bat -l man"
#alias nvim '/nix/store/xvvamk9nz090hjv0qf12g78jwvkap22l-neovim-0.9.5/bin/nvim'




#-----------aliases----------------
alias nvim '/home/kenzo/.config/nvim/config/result/bin/nvim'
alias zz ranger
alias nv nvim
alias rmi 'rm -i'
alias fs 'source ~/.config/fish/config.fish'
alias bb '../../'

#--------------git aliases----------------
alias gst 'git status .'
alias gp 'git push -u origin'
alias gll 'git log -1 HEAD --stat'
alias gc 'git commit -m'
alias grv 'git remote -v'
alias glog "git log --graph --pretty=format:'%C(red)%h%Creset -%C(yellow)%d%Creset %s %C(green)(%cr)%C(yellow)<%an>%Creset'"
alias gch 'git checkout'
alias gua 'git reset'
alias gitmad 'git reset --hard HEAD'

starship init fish | source
