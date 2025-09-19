#!/bin/bash
source modules/data_storage.sh

select_all(){
    if [ ! -f "./DATA/$1/$2.txt" ]; then
        echo "$2 table not found!"
        return 1
    fi
    cat "./DATA/$1/$2.txt" | column -t -s','
}