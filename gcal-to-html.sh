#!/bin/bash
# this is a script to make a html page of the calendar
# prereq: gcalcli  https://github.com/insanum/gcalcli
#

gcal_out=$(mktemp)
html_out=$(mktemp)
#html_dest="/home/pi/gcal.html"
html_dest="/home/pi/MagicMirror/modules/MMM-HTMLBox/gcal.html"

function gcal_cleanup
{
rm $gcal_out
rm $html_out

}

trap gcal_cleanup exit

#get the current agenda
gcalcli --cal kbemus@gmail.com --nocolor agenda >> $gcal_out
sed -i ':a;N;$!ba;s/\n/<br> /g;s/             /\&nbsp\; \&nbsp\; /g;s/          /<br>\&nbsp\; \&nbsp\; /g;s/   /<br>\&nbsp\; \&nbsp\; /g' $gcal_out
#sed -i ':a;N;$!ba;s/\n/<br> /g' $gcal_out

echo '<p style="font-family: Arial, Helvetica, sans-serif;font-size: 20px;line-height: 25px;"> ' >> $html_out
cat $gcal_out >> $html_out
echo "<br> " >> $html_out
echo "<hr> " >> $html_out
echo '<p style="font-family: Arial, Helvetica, sans-serif;font-size: 20px;line-height: 25px;"> ' >> $html_out
echo "updated at `date` " >> $html_out
echo "</p> " >> $html_out

cp $html_out $html_dest


exit
