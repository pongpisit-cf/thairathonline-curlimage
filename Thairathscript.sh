#!/bin/bash

# Set the destination URL and local directory
DEST_URL="https://www.thairath.co.th/home"
LOCAL_DIR="$HOME/tmp-thairath"

# Create tmp folder and go inside folder
mkdir $LOCAL_DIR
cd $LOCAL_DIR

# Get html file
wget -P $LOCAL_DIR $DEST_URL -O index.html
mv index.html $LOCAL_DIR

# Extract only images files (In this example is jpg and png) write to output name imglist.txt
grep -oE 'https?://[^"]+\.(jpg|png)' $LOCAL_DIR/index.html > $LOCAL_DIR/imglist.txt

# Start curl loop that gets input from imglist.txt to download every image.
while read line; do curl -sS $line -o $LOCAL_DIR/$(basename $line) >/dev/null 2>&1; done < $LOCAL_DIR/imglist.txt

# Clean folder
rm $LOCAL_DIR/*.*
