YSH=$(dirname "$0")

ysh-update() {
    prev_dir=$(pwd)
    cd $YSH
    echo "Updating ysh..."
    git pull
    touch .last-update
    cd "$prev_dir"
}

# if older than one day, update
if test "`find $YSH/.last-update -mtime +1`"; then
    ysh-update
fi
