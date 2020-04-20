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
gcalcli --cal xxxx@gmail.com --nocolor agenda "`date +%F`" "`date -d "+7 days" +%F`" >> $gcal_out
sed -i ':a;N;$!ba;s/\n/<br> /g;s/             /\&nbsp\; \&nbsp\; /g;s/          /<br>\&nbsp\; \&nbsp\; /g;s/   /<br>\&nbsp\; \&nbsp\; /g' $gcal_out
sed -i -e :a -e 's/\([0-9]\)  \([0-9]\)/\1 <br>\&nbsp\; \&nbsp\; \2/;ta' $gcal_out

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
