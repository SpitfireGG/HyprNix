set fish_greeting 

jump shell fish | source

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

set -x GOPATH $HOME/go
set -x PATH $PATH /usr/bin/cargo

alias zz ranger
alias xx xplr


starship init fish | source
