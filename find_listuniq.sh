# shell program which finds files based on certain criteria, 
# then prints out a unique list of the directories containing those files, 
# with no. of files within that directory that were found. 
# eg dir/found/in/search : 11 files


FILECOUNT=0
SEARCH_DIR="$HOME/Desktop/Dropbox/Tech/CS/Python"
CUR_DIR=$SEARCH_DIR

echo "Directory  :  files found matching criteria "
echo "-----------   ----------------------------- "
for file in $(find $SEARCH_DIR -type f -iname "*.py" -mtime -52w); do 
    # #get name of enclosing directory
    ENCL_DIR=$(echo $file | sed "s|$HOME||" | sed -E "s|[a-z A-Z _ 0-9 -]+\.py$||" )
    #start counting # times this directory shows up in search
    FILECOUNT=$[$FILECOUNT+1]
    #when moving onto another directory, print name of previous directory & # files that were turned up in that directory
    if [[ "$ENCL_DIR" != "$CUR_DIR" ]]; then
        echo $CUR_DIR" : "$FILECOUNT
        FILECOUNT=1
        CUR_DIR=$ENCL_DIR
    fi
done

