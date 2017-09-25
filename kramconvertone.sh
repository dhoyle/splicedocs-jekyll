#!/bin/bash
f=$1
filename="${f##*/}"
base="${filename%.[^.]*}"
echo "Converting file $base.html to $base.md"

count=`wc -l $base.html | awk '{print $1}'`
breakpoint=`grep -n -m2 [-][-][-] $base.html | tail -1 | cut -d: -f1`
touch $base.head
touch $base.tail
head -$((breakpoint)) $base.html > $base.head
tail -$((count - breakpoint)) $base.html > $base.tail

kramdown -i html -o kramdown $base.tail > $base.tmp
cat $base.head $base.tmp > $base.md
rm $base.head $base.tail $base.tmp
echo "   --> File conversion done"
