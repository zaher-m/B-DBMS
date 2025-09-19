#!/bin/bash
source modules/data_storage.sh

: '
============================================================
 table_ops.sh

 Provides higher-level table operations for the DBMS.
 Built on top of `data_storage.sh`.

 It handles:
   - Creating and dropping tables
   - Inserting new records into tables
   - Updating existing records by ID
   - Deleting records by ID
   
============================================================
'

create_table(){
    if [ -f "./DATA/$1/$2.txt" ]; then
        echo -e "\n $2 Table already exists! \n"
        return 1
    fi
    if [[ ! $2 =~ ^[a-zA-Z0-9]+$ ]]; then
        echo -e "\n Invalid name for a table \n"
        return 1
    fi
    write_header "$1" "$2" "$3"
    echo -e "\n Table $2 created successfully! \n"
}

drop_table() {
    if [ ! -f "./DATA/$1/$2.txt" ]; then
        echo -e "\n Table: $2 not found in database: $1 \n"
        return 1
    fi
    delete_file "$1" "$2"
    if [ $? -eq 0 ]; then
        echo -e "\n Table $2 dropped successfully \n"
    else
        echo -e "\n Failed to drop table $$2 \n"
        return 1
    fi
}

insert_record(){
    local db_name="$1"
    local table_name="$2"
    local values="$3"
    if [ ! -f "./DATA/$1/$2.txt" ]; then
        echo -e "\n Table $2 not found \n"
        return 1
    fi
    append_record "$db_name" "$table_name" "$values"
    local id=$(echo "$values" | cut -d',' -f1)
    echo "Recorded ad ID -> $id"
}

update_record(){
    local db_name="$1"
    local table_name="$2"
    local id="$3"
    local values="$4"
    if [ ! -f "./DATA/$1/$2.txt" ]; then
        echo -e "\n Table $2 not found \n"
        return 1
    fi
    local found=0
    local new_content=""
    while IFS=',' read -r record_id rest; do
        if [ "$record_id" = "$id" ]; then
            new_content+="$id,$values"$'\n'
            found=1
        else
            new_content+="$record_id,$rest"$'\n'
        fi
    done < "./DATA/$1/$2.txt"
    if [ $found -eq 0 ]; then
        echo -e "\n Didn't find a match with provided id: $id! \n"
        return 1
    fi
    update_file "$db_name" "$table_name" "$new_content"
    echo -e "\n Updated successfully with record id: $id! \n"
}

delete_record() {
    local db_name="$1"
    local table_name="$2"
    local id="$3"
    if [ ! -f "./DATA/$1/$2.txt" ]; then
        echo -e "\n Table $2 not found \n"
        return 1
    fi
    local found=0
    local new_content=""
    while IFS=',' read -r record_id rest; do
        if [ "$record_id" != "$id" ]; then
            new_content+="$record_id,$rest"$'\n'
        else
            found=1
        fi
    done < "./DATA/$1/$2.txt"
    if [ $found -eq 0 ]; then
        echo -e "\n Record ID $id not found \n"
        return 1
    fi
    update_file "$db_name" "$table_name" "$new_content"
    echo -e "\n Deleted successfully with record ID: $id! \n"
}
