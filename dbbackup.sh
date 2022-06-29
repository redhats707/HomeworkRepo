#!/bin/bash

#Will use  this Variable later in the script to check if user have xtrabackup tool installed or not.
TOOL="xtrabackup"

clear

#Help function

HELP () {
  echo "-Script will make Full Backup + Compression of your DB"
  echo "-All command line switches [-s -d -u -p] are required."
  echo ""
  echo "-No spaces or Equal sign (=) required after switches"
  echo "-Syntax Example: -s/example/dir -d/example/dir -u'username' -p\$PASSWORD" 
  echo "  *password field can accept both Global Variable and just password itself"
  echo ""
  echo " -s  -- Source directory  (The source directory for the backup. This should be the same as the datadir for your MySQL server, so it should be read from /etc/my.cnf file)"
  echo " -d  --Target directory (Destination directory for the backup)"
  echo " -u  --DB username."
  echo " -p  --DB password."
  echo " -h  --Displays this help message. No further functions are performed."
  exit 1

}

#Will Check the number of arguments. If none are passed, print help and exit.

NUMARGS=$#
if [ $NUMARGS -eq 0 ]; then
  HELP
fi
while getopts s:d:u:p:h: OPTIONS; do
  case "${OPTIONS}" in
    s)
      source_directory="${OPTARG}"
      ;;

    d)
      destination_directory="${OPTARG}"
      ;;

    u)
      user="${OPTARG}"
      ;;
	
    p)
     password="${OPTARG}"
     ;;


    h) HELP
       ;;

   \?) echo -e "Option $OPTARG not allowed."
       HELP
       ;;
  esac
done

#Checks if destination directory doesn't exist will create one and if source directory not correct will exit with error message

if [ ! -d "$destination__directory" ]
   then
        mkdir -p "$destination_directory"
	
   elif [ ! -d "$source_directory" ] 
   then	
	echo "Directory doesn't exist, please check and rerun the script"
	echo "Hint: You can find more detailed info about your DB's data directory  in /etc/.my.cnf file"
  exit 1
fi


#Backup script itself  with xtrabackup command and compression of directory using combination of tar+gzip

xtrabackup --backup --datadir=$source_directory --target-dir=$destination_directory --user=$user --password=$password

tar -zcvf $destination_directory.$(date +%Y.%m.%d.)tar.gz $destination_directory/*





#If xtrabackup tool not installed will exit with info message

if ! command -v ${TOOL} >/dev/null; then
  echo "This script requires ${TOOL} to be installed"
  exit 1
fi
