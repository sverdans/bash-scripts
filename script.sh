SRC_DIR="$1"
DST_DIR="$2"

if [ -z "$SRC_DIR" ]; then
	echo "error: src and dst dirs not declared"; exit 1
fi

if [ -z "$DST_DIR" ]; then
	echo "error: dst dir not declared"; exit 1
fi

if [ ! -d "$SRC_DIR" ]; then
	echo "error: dir '$SRC_DIR' does not exist."; exit 1
fi

if [ ! -d "$DST_DIR" ]; then
	echo "error: dir '$DST_DIR' does not exist."; exit 1
fi

COPIED_COUNT=0
SKIPED_COUNT=0

FILES=`find $SRC_DIR/*`
for FILE in $FILES
do
	FILENAME=${FILE#$SRC_DIR}
	DST_FILEPATH=$DST_DIR$FILENAME
	
	if [ -f $DST_FILEPATH ]; then
		while true; do
			read -p "owerwite '$DST_FILEPATH'? [y/n] : " yn
			case $yn in
				[Yy]* ) cp $FILE $DST_FILEPATH; ((COPIED_COUNT++)); break;;
				[Nn]* ) ((SKIPED_COUNT++)); break;;
			esac
		done
	elif [ -f $FILE ]; then
		cp $FILE $DST_FILEPATH;
		((COPIED_COUNT++));
	else
		mkdir -p $DST_FILEPATH;
	fi
done

echo "copied files count: $COPIED_COUNT"
echo "skiped files count: $SKIPED_COUNT"

exit 0
