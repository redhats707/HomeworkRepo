#!/bin/bash


echo "Type the directory name with full path that you want to archive"
read folder

# Choose type of archive
echo "Choose Extension:"

echo "1.tar"
echo "2.zip"
echo "3.tar.bz2"
echo "4.tar.gz"
read inp

#Set  name for your archive

echo "Enter name of your archive"
read FNAME

# Switch Case


case $inp in
  1)format= tar -czf $FNAME.tar $folder
  ;;
  2)format= zip -r  $FNAME.zip $folder
  ;;
  3)format= tar -cjf $FNAME.tar.bz2 $folder
  ;;
  4)format= tar -czf $FNAME.tar.gz $folder
  ;;
esac
echo "Your directory has been archived, check your current directory"
 
