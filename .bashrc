# ghq + peco https://gfx.hatenablog.com/entry/2017/07/26/104634
alias g='cd $(ghq root)/$(ghq list | peco)'
alias v='code $(ghq root)/$(ghq list | peco)'
alias b='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

# ssh + peco https://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
alias s='ssh $(grep -iE "^host[[:space:]]+[^*]" ~/.ssh/config|peco|awk "{print \$2}")'

