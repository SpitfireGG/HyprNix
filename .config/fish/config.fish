set fish_greeting

jump shell fish | source

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.nix-profile/bin/ghc:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

set -x GOPATH $HOME/go
set -x PATH $PATH /usr/bin/cargo






#-----------aliases----------------






#Syntax highlighting for manpage - better understanding :)
# can also be achieved by using Pager 

function shit
    man $argv | bat --plain --language=man
end


function copy
  find $argv[1] -type f -name $argv[2] | tee /dev/tty | xclip  -selection clipboard 
end 





alias nvim '/home/kenzo/.config/nixvim/result/bin/nvim'
alias zz ranger
alias nv nvim
alias rmi 'rm -i'
alias fs 'source ~/.config/fish/config.fish'
alias bb 'cd ../../'
alias fuck 'nvim $(fzf --preview="bat {}")'

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
