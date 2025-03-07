#!/bin/bash
echo "Converting html files in current directory to kramdown"
cnt=0
for f in *.html
do
   filename="${f##*/}"
   base="${filename%.[^.]*}"
   echo "Converting file $base.html to $base.md"

   count=`wc -l $base.html | awk '{print $1}'`
   breakpoint=`grep -n [-][-][-] $base.html | tail -1 | cut -d: -f1`
   touch $base.head
   touch $base.tail
   head -$((breakpoint)) $base.html > $base.head
   tail -$((count - breakpoint)) $base.html > $base.tail

   kramdown -i html -o kramdown --syntax-highlighter +nil+ $base.tail > $base.tmp
   cat $base.head $base.tmp > $base.md
   rm $base.head $base.tail $base.tmp
   echo "   --> File conversion done"
   cnt=$[$cnt +1]
done
echo "Converted $cnt files to kramdown"
