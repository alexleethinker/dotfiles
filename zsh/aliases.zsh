# copy
alias c='xclip -selection c'

# dog, a better cat
alias dog='pygmentize -g'

# vim =/
alias :wq="exit"

# go back one commit
alias rollback="git reset HEAD~"

# pretty git log
alias gplg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# docker-compose
alias dc="docker-compose"

# my prettier way
alias p="prettier --single-quote --print-width 100 --trailing-comma all --write"

# fu concurrent
alias fu="fu -c"
