lazy() {
    git add .
        git commit --allow-empty-message --no-edit
        git push
}

gitfirst() {
    git checkout -b main
        git push -u origin main
}

gitn() {
    git log --reverse --pretty=%H master | grep -A 1 $(git rev-parse HEAD) | tail -n1 | xargs git checkout
}
gitp() {
    git checkout HEAD^1
}

backup() {
    cd ~/Dotfiles
        lazy
        cd -
}

giti() {
    printf $'\n'"$@" >> .gitignore
}

h() {
    count="${1:-25}"
        history $count
}

sha256() {
    printf '%s %s\n' "$1" "$2" | sha256sum --check
}
md5() {
    printf '%s %s\n' "$1" "$2" | md5sum --check
}

function size() {
    du -sh $1
}

function ..() {
    cd ..
        ls
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
    *.tar.gz)    tar xzf $1   ;;
    *.tar.xz)    tar xf $1   ;;
    *.bz2)       bunzip2 $1   ;;
    *.rar)       unrar x $1     ;;
    *.gz)        gunzip -v $1    ;;
    *.tar)       tar xf $1    ;;
    *.tbz2)      tar xjf $1   ;;
    *.tgz)       tar xzf $1   ;;
    *.zip)       unzip $1     ;;
    *.Z)         uncompress $1;;
    *.7z)        7z x $1      ;;
    *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
    else
        echo "'$1' is not a valid file"
            fi
}

man() {
    vi -c "Man $1" -c "1q"
}

copy() {
        $1 | xclip -selection clipboard
    }
