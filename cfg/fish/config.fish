set -g fish_greeting ""

starship init fish | source

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# add the go bin path to be able to execute our programs
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PATH $PATH /usr/bin/cargo

#aliases
alias zz ranger
alias xx xplr
