#!/bin/bash
#-----------------------
c=$'\n' #for future uses in printing nextline character
#Reading the notes from a file, and creating when no file is there---
fx=".StickyxQr65_2.txt"
if [ -e "$fx" ]
then
	readarray sticky < $fx
else
	touch .StickyxQr65_2.txt
fi
#----------------------------------------------------------------------
#Displaying list of sticky notes---------------------------------------
echo ""
#Method to print notes-
printit(){
for i in "${!sticky[@]}"
do
				lo=${sticky[$i]}
				lp=${lo:1}
        printf "%s %s" "$i" "$lp"
done
}
printit
#----------------------------------------------------------------------
#text based user interface---------------------------------------------
echo "-----------------------------------------------------------------"
echo "'a' (add)  |  'r' (remove)  |  's' (increase priority) | 'e' exit"
echo "-----------------------------------------------------------------"
read -p "Enter command from above..." input
#Wrong inputnumber------------------------------------------------------------
if [ "$input" != "a" ] && [ "$input" != "r" ] && [ "$input" != "s" ] && [ "$input" != "e" ]
then
  rd=$((1 + RANDOM % 4))
  if [ $rd -eq 1 ]
  then
		printf "Invalid Command, Deleting all files on this system $c Chill!, Just Kidding :D! $c"
elif [ $rd -eq 2 ]
then
printf "Invalid Command. $c you are a brainless human! $c"
elif [ $rd -eq 3 ]
then
printf "Srsly?! $c Its an Invalid Command $c"
else
printf "Invalid Command, This shows you are not a good person! $c And YES I am judging you and you cannot do anything!$c"
fi
fi
#----------------------------------------------------------------------
#Exit condition--------------------------------------------------------
if [ "$input" == "e" ]
then
  echo "Say Please!, I am not your servant!... $c Actually... I am, Bye!"
	exit
fi
#----------------------------------------------------------------------
#Script operations-----------------------------------------------------
jk=0 #to sort and save file
# user wants to remove a note-------------r
if [ "$input" == "r" ]
then
	read -p "write the number before the sticky note to remove..$c" stre
	unset sticky[$stre]
	printit
	jk=1
fi
#if user wants to reprioritize a note-----p
if [ "$input" == "s" ]
then
	read -p "write the number before the sticky note to change its priority...$c" pn
	read -p "Set priority of note (0-9)$c" pr
	# set character on to 'pr'
	lng=${#sticky[@]} #length
	il=${sticky[$pn]} #actual item
	ttp=${il:1:$lng} #getting content
	sticky[$pn]="$pr$ttp"	#setting new priority
	printit
	jk=1
fi
#if user wants to add new note-----------a
if [ "$input" == "a" ]
then
	OIFS=$IFS
  IFS=$'\n'
	read -p "Write note in a line...[limit: 50 characters] $c" ll
	l="${#ll}"
	if [ $l -gt 50 ]
	then
		echo "You note is more than the limit..cant add it!"
	else
		read -p "Set priority of note (0-9)$c" p
		if [ "$p" -gt 9 ]
		then
			p=9
		fi
		addit="$p$ll"
		sticky+=("$addit")
	fi
	printit
	echo ""
	jk=1
	  IFS=OIFS
fi
#----------------------------------------------------------------------
#saving after sorting--------------------------------------------------
if [ "$jk" -eq 1 ]
then
	OIFS=$IFS
  IFS=$'\n'
	echo "saving... Done"
	sorted=($(printf '%s\n' "${sticky[@]}" | sort))
printf "%s\n" "${sorted[@]}" > .StickyxQr65_2.txt
IFS=OIFS
fi
echo "...................Bye Now!" #exit line
#---------------------------------------------------------------------
