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

function vv
    man $argv[1] $argv[2] | bat --plain --language=man
end


function copy
  find $argv[1] -type f -name $argv[2] | tee /dev/tty | xclip  -selection clipboard 
end 

function noc
  set -l command_string (string join " " $argv)

  echo "Running: $command_string" # Optional: show the user the command being run

  command $argv

  set -l exit_status $status

  if $exit_status -eq 0
    # Success (exit status 0)
    dunstify \
      -u low \
      -i emblem-ok \
      "Success" \
      "'$command_string' completed successfully."
  else
    # Failure (non-zero exit status)
    dunstify \
      -u critical \
      -i emblem-error \
      "Failed ($exit_status)" \
      "'$command_string' exited with status $exit_status."
  end

  return $exit_status
end



alias nvim '/home/kenzo/.config/nixvim/result/bin/nvim'
alias zz ranger
alias nv nvim
alias rmi 'rm -i'
alias fs 'source ~/.config/fish/config.fish'
alias bb 'cd ../../'
alias fuck 'nvim $(fzf --preview="bat {}")'

#-------------- git aliases ----------------
# -- functions --
function gstt
    git status --short | fzf --multi | awk '{print $2}' | xargs git add
      git status
end

function gswitch
  git checkout $argv[1] &&  nvim $(find . -type f -name '*.asm' | fzf)

end



#----------------- end -------------------------
alias gst 'git status .'
alias gp 'git push -u origin'
alias gpm 'git push -u origin main'
alias gll 'git log -1 HEAD --stat'
alias gc 'git commit -m'
alias grv 'git remote -v'
alias glog "git log --graph --pretty=format:'%C(red)%h%Creset -%C(yellow)%d%Creset %s %C(green)(%cr)%C(yellow)<%an>%Creset'"
alias gco 'git checkout'
alias gcb 'git checkout'
alias gua 'git reset'
alias gitmad 'git reset --hard HEAD'

# -- fast branch switching -- 
# --- project dependent ---
alias gbr='git branch -v'
alias gbf='git branch | fzf | xargs git checkout'  # Interactive branch selection with fzf
alias gch01='git checkout ch01'
alias gchasm='git checkout x86_64_intel_guide'




starship init fish | source
