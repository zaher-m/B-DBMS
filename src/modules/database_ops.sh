create_database(){
    if [ -d "./dbms_databases/$1" ]; then
        echo "Database $1 already exists"
        return 1
    fi

    # if non alphanumeric 
    if [ ]; then
        echo "Invalid database name!"
        return 1
    fi 

    create_directory "$1"
    echo "Database $1 created successfully!"
}   

list_databases(){
    db_count=$(ls -d ./dbms_databases/*/ 2>/dev/null | wc -l)    
    if [$db_count -eq 0]; then
        echo "No databases found!"
        return 
    fi
    ls -d ./dbms_databases/*/ 2>/dev/null | while read dir; do
        # strips the leading directory path, leaving only the last part.
        basename "$dir"
    done
}