#!/bin/bash
source modules/data_storage.sh

create_database(){
    if [ -d "./dbms_databases/$1" ]; then
        echo "Database $1 already exists"
        return 1
    fi
    # if non alphanumeric 
    if [[ ! $1 =~ ^[a-zA-Z0-9]+$ ]]; then
        echo "Invalid database name!"
        return 1
    fi 
    create_directory "$1"
    echo "Database $1 created successfully!"
}   

connect_database(){
    if [ ! -d "./dbms_databases/$1" ];then
        echo "$1 database not found!"
        return
    fi
    echo "Connected to $1 database successfully!"
}

list_databases(){
    local db_count=$(ls -d ./dbms_databases/*/ 2>/dev/null | wc -l)    
    if [ $db_count -eq 0 ]; then
        echo "No databases found!"
        return 
    fi
    ls -d ./dbms_databases/*/ 2>/dev/null | while read dir; do
        # strips the leading directory path, leaving only the last part.
        basename "$dir"
    done
}

drop_database(){
    if [ ! -d "./dbms_databases/$1" ];then
        echo "Error: database $1 not fount!"
        return
    fi
    read -p "Confirm delete $1? (y/n)" confirm
    if [ $confirm == "y" ];then
        delete_directory "$1"
        echo "$1 database removed successfully!"
        return 1
    fi
    return
}

