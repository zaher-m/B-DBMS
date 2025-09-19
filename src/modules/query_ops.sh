#!/bin/bash
source modules/data_storage.sh

select_all(){
    if [ ! -f "./dbms_databases/$1/$2.txt" ]; then
        echo "$2 table not found!"
        return 1
    fi
    cat "./dbms_databases/$1/$2.txt" | column -t -s','
}