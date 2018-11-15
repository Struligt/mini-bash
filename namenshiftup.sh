# this shell program goes down 1 level , moves them up one level, while renaming them to the diretory which contained them

COUNT=0;
MAXN=1250;
for i in * ; do 
	if [ -d "$i" ]; then
		# store name of directory but remove all whitespaces from it (need extended reg exp) & remove .extension from name
		NAME=$(echo "$i"|sed -E "s/[[:space:]]+//g"|sed -E "s/\..*$//")
		# move to directory
		cd "$i"
		# if number of files =1 & file = TXT.rtf , then copy it up & rename it to the stored name
		NUMFILES=$(ls |wc -l)
		if [ $NUMFILES -eq '1' ]; then
			# echo $NAME
			FNAME=$(ls)
			#remove .extension from name, replace with dir name from above
			NNAME=$(echo "$FNAME"|sed -E "s/^.+\./$NAME\./") 
			#once to check...
			echo "mv "$FNAME" ../"$NNAME""
			#twice to go...
			mv "$FNAME" ../"$NNAME"
			# increment number of files moved
			COUNT="$(expr "$COUNT" '+' '1')"
		fi
		cd .. 
		# exit loop if more than MAXN files moved
		if [ $COUNT -gt $MAXN ]; then
			break
		fi
	fi
done