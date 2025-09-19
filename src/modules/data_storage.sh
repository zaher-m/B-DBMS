#!/bin/bash

: '
============================================================
 data_storage.sh

 Provides low-level file operations for the DBMS.
 It handles:
   - Creating and deleting database directories
   - Writing table headers and appending new records
   - Updating an entire table file with new content
   - Deleting table files when dropped

 All data is stored under the ./DATA directory,
 with each database as a subfolder and each table as a .txt file.
============================================================
'

create_directory(){
    mkdir -p "DATA/$1"
}

delete_directory(){
    rm -rf "DATA/$1"
}

write_header(){
    echo "$3" > "./DATA/$1/$2.txt"
}

append_record(){
    echo "$3" >> "./DATA/$1/$2.txt"
}

update_file(){
  echo "$3" > "./DATA/$1/$2.txt"  
}

delete_file(){
    rm "./DATA/$1/$2.txt"
}