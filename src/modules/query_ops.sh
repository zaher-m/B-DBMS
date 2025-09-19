#!/bin/bash
source modules/data_storage.sh

: '
============================================================
 query_ops.sh

 Provides query-related operations 
 for the DBMS, built on top of data_storage.sh.

 It currently supports:
   - Selecting and displaying all records 
     from a given table in a formatted view

============================================================
'

select_all(){
    if [ ! -f "./DATA/$1/$2.txt" ]; then
        echo -e "\n $2 table not found! \n"
        return 1
    fi
    cat "./DATA/$1/$2.txt" | column -t -s','
}