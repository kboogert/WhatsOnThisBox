#!/bin/bash

today="$( date +"%Y%m%d" )"
number=0

base=WhatsOnThisBox
bashdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
file=$base-$today.txt
txtfile="update.txt"

cd $bashdir

while [ -e "$file" ]; do
    printf -v file -- "$base-%s-%02d.txt" "$today" "$(( ++number ))"
done
# echo $file

echo "******* What's on this Box *******" > $file
if [ -e $txtfile ]; then
  cat $txtfile >> $file
fi

cat << EOF >> $file

Included are
	Installed mac applications (in applications directory)
	Things installed globally with npm
	Things installed locally with npm (need to uncomment)
	Things install with homebrew

----------------------------------------------------------------------------
EOF

echo "----- Applications (.app) --------------------------------------------------" >> $file
ls -1 /Applications/ >> $file
echo  >> $file

echo "----- npm global -----------------------------------------------------------" >> $file
PATH=$PATH:/usr/local/bin
npm --global --depth=0 ls >> $file
echo  >> $file

# echo "----- npm local ------------------------------------------------------------" >> $file
# cd to directory to want to save
# npm --depth=0 ls >> $file
# cd $bashdir
# echo  >> $file

echo "----- brew list ------------------------------------------------------------" >> $file
/usr/local/bin/brew list >> $file
echo  >> $file

echo "----- VSCODE Extensions ----------------------------------------------------" >> $file
code --list-extensions --show-versions >> $file
echo  >> $file


# -----Save all the stuff now ----------------------

# pwd; ls -t $base"-*.txt"
previousUpdate=`ls -t $base-*.txt | sed -n 2p`
# echo "previousUpdate = $previousUpdate \n file = $file"
echo "******* What's on this Box *******"; echo " "
if [ -e "$previousUpdate" ]; then
	cmp --silent $previousUpdate $file
	if [ $? -ne 0 ] ; then
		# files are different
		echo "Configuration has differences"
    echo ">From diff $previousUpdate $file"
		diff $previousUpdate $file
 	else
		echo "No differences"
		rm $previousUpdate
	fi
else
	echo "No previous update found"
fi
ln -Fs $file $base".txt"
echo " "
echo "$base.txt for What's On This Box updated"
count=`ls -t "$base"-*.txt | tail -n +4 | wc -l | tr -d '[:space:]'`
ls -t "$base"-*.txt | tail -n +4 | xargs rm --
if [ $count -gt 1 ]; then
	echo " - $count older files removed"
fi


# check if no files exist.... something when very bad
num=`ls -t "$base"-*.txt  | wc -l`
if [ $num -lt 1 ]; then
	echo "Error: No configuration files exist"
	exit 1
fi
exit
# ls -lat WhatsOnThisBox-*.txt
# ls -la WhatsOnThisBox.txt


