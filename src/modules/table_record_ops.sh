#!/bin/bash
source modules/data_storage.sh

create_table(){
    if [ -f "./dbms_databases/$1/$2.txt" ]; then
        echo "$2 Table already exists!"
        return 1
    fi
    if [[ ! $2 =~ ^[a-zA-Z0-9]+$ ]]; then
        echo "Invalid name for a table"
        return 1
    fi
    write_header "$1" "$2" "$3"
    echo "Table $2 created successfully!"
}

drop_table() {
    if [ ! -f "./dbms_databases/$1/$2.txt" ]; then
        echo "Table: $2 not found in database: $1"
        return 1
    fi
    delete_file "$1" "$2"
    if [ $? -eq 0 ]; then
        echo "Table $2 dropped successfully"
    else
        echo "Failed to drop table $$2"
        return 1
    fi
}

insert_record(){
    local db_name="$1"
    local table_name="$2"
    local values="$3"
    if [ ! -f "./dbms_databases/$1/$2.txt" ]; then
        echo "Table $2 not found"
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
    if [ ! -f "./dbms_databases/$1/$2.txt" ]; then
        echo "Table $2 not found"
        return 1
    fi
    local found=0
    local new_content=""
    while IFS=',' read -r record_id rest; do
        if [ "$record_id" = "$id" ]; then
            new_content+="$id,$new_values\n"
            found=1
        else
            new_content+="$record_id,$rest\n"
        fi
    done < "./dbms_databases/$1/$2.txt"
    if [ $found -eq 0 ]; then
        echo "Didn't find a match with provided id: $id!"
        return 1
    fi
    update_file "$db_name" "$table_name" "$new_content"
    echo "Updated successfully with record id: $id!"
}

delete_record() {
    local db_name="$1"
    local table_name="$2"
    local id="$3"
    if [ ! -f "./dbms_databases/$1/$2.txt" ]; then
        echo "Table $2 not found"
        return 1
    fi
    local found=0
    local new_content=""
    while IFS=',' read -r record_id rest; do
        if [ "$record_id" != "$id" ]; then
            new_content+="$record_id,$rest\n"
        else
            found=1
        fi
    done < "./dbms_databases/$1/$2.txt"
    if [ $found -eq 0 ]; then
        echo "Record ID $id not found"
        return 1
    fi
    update_file "$db_name" "$table_name" "$new_content"
    echo "Deleted successfully with record ID: $id!"
}