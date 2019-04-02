in_git_repo() {
	[[ -d .git ]] && echo ' '
}

# Wrap git. On errors, print an additional line in red.
git(){
    command git "$@"
    local exitCode=$?
    if [ $exitCode -ne 0 ]; then
        printf "\033[0;31mERROR: git exited with code $exitCode\033[0m\n"
        return $exitCode
    fi
}

git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# sets the title of the terminal
function title {
  printf "\033]0;%s\007" "$*"
}

cyan="$(tput setaf 6)" #"\[tput setaf 6\]"
magenta="$(tput setaf 5)"
default="$(tput sgr0)"

PS1='\[${cyan}\]\u@macbook:\w$(in_git_repo)\[${magenta}\]$(git_branch) \[${cyan}\]$\[${default}\] '

alias ls="ls -G"
alias grep="grep --color"
alias gdiff="git diff --color=always --no-index $1 $2"

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export JAVA_HOME="$( /usr/libexec/java_home )"
export GOPATH=~/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin
