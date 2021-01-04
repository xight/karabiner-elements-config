#!/bin/bash

TARGET_ROOT=$HOME/.config/karabiner/assets/complex_modifications
SOURCE_ROOT=$PWD/complex_modifications

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

if [[ ! -e $TARGET_ROOT ]]; then
	mkdir -p $TARGET_ROOT
fi

echo 'install start'

for FILE in `find $SOURCE_ROOT/*.json -type f | awk -F"/" '{ print $NF }'`;
do
	relink $TARGET_ROOT/$FILE $SOURCE_ROOT/$FILE
done

echo "done"
