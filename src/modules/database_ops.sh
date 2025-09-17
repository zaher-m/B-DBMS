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

