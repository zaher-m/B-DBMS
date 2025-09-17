#!/bin/bash

create_directory(){
    mkdir -p "dbms_databases/$1"
}

delete_directory(){
    rm -rf "dbms_databases/$1"
}

# adds table's header to a file, refer to menu sequence where $1:database name, $2:table name, $3:table header
write_header(){
    echo "$3" > "./dbms_databases/$1/$2.txt"
}

append_record(){
    echo "$3" >> "./dbms_databases/$1/$2.txt"
}

update_file() {
  echo "$" > "./dbms_databases/$1/$2.txt"  
}

delete_file(){
    rm "./dbms_databases/$1/$2.txt"
}