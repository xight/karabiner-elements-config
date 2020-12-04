#!/bin/bash

# relink target-file source-file
relink() {
	if [[ -h "$1" ]]; then
		echo "Relinking $1"
		# Symbolic link? Then recreate.
		rm "$1"
		ln -sn "$2" "$1"
	elif [[ ! -e "$1" ]]; then
		echo "Linking $1 to $2"
		ln -sn "$2" "$1"
	else
		echo "$1 exists as a real file, skipping."
	fi
}

#DIR=$( cd "$( dirname "$0" )" && pwd )

#IFS=\

TARGET="$HOME/.config/karabiner/assets/complex_modifications"

echo 'install start'

for FILE in `find *.json -type f | awk -F"/" '{ print $NF }'`;
do
	relink $TARGET/$FILE $PWD/$FILE
done

echo "done"
