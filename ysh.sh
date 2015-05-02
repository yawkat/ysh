YSH=$(dirname "$0")

# if older than one day, update
if test "`find $YSH/.last-update -mtime +1`"; then
    prev_dir=$(pwd)
    cd $YSH
    echo "Updating ysh..."
    git pull
    touch .last-update
    cd "$prev_dir"
fi

source $YSH/base.sh
