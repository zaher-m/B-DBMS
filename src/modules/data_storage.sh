#!/bin/bash

create_directory(){
    mkdir -p "DATA/$1"
}

delete_directory(){
    rm -rf "DATA/$1"
}

# adds table's header to a file, refer to menu sequence where $1:database name, $2:table name, $3:table header
write_header(){
    echo "$3" > "./DATA/$1/$2.txt"
}

append_record(){
    echo "$3" >> "./DATA/$1/$2.txt"
}

update_file() {
  echo "$3" > "./DATA/$1/$2.txt"  
}

delete_file(){
    rm "./DATA/$1/$2.txt"
}