#!/bin/bash
source modules/database_ops.sh

CURRENT_DB=""
show_main_menu() {
  echo "DBMS Menu:"
  echo "1. Create Database"
  echo "2. List Databases"
  echo "3. Connect to Database"
  echo "4. Drop Database"
  echo "5. Exit"
}
show_sub_menu() {
  echo "Database: $CURRENT_DB"
  echo "1. Create Table"
  echo "2. Insert Record"
  echo "3. Update Record"
  echo "4. Delete Record"
  echo "5. Query Table"
  echo "6. Back to Main Menu"
}

main_loop() {
  while true; do
    show_main_menu
    read -p "Choice: " choice
    case $choice in
      1)
        read -p "Enter database name: " db_name
        # a database manager creates a database with the provided name
        echo "database $db_name created!"
        ;;
      2)
        # a database manager lists all available databases
        ;;
      3)
        read -p "Enter database name: " db_name
        # a database manager connects to the provided database name 
        # set the CURRENT_DB=db_name
        # show sub menu
        sub_menu_loop
        ;;
      4)
        read -p "Enter database name: " db_name
        # a database manager deletes the specified database
        ;;
      5)
        echo "Exiting"
        exit 0
        ;;
      *)
        echo "Invalid choice"
        ;;
    esac
  done
}

sub_menu_loop() {
  while true; do
    show_sub_menu
    read -p "Choice: " choice
    case $choice in
      1)
        read -p "Enter table name: " table_name
        read -p "Enter comma-separated fields(Name,Age, etc): " fields
        # a table manager creates a table with provided fields
        ;;
      2)
        read -p "Enter table name: " table_name
        read -p "Enter values: " values
        # a table manager inserts record to selected table
        ;;
      3)
        read -p "Enter table name: " table_name
        read -p "Enter ID to update: " id
        # identifier required to select specific record!!
        read -p "Enter new values (comma-separated): " values
        # a table manager updates selected table with provided values
        ;;
      4)
        read -p "Enter table name: " table_name
        read -p "Enter ID to delete: " id
        # a table manager delets selected record in selected table
        ;;
      5)
        read -p "Enter table name: " table_name
        read -p "Enter query (all or field name): " query
        # a query module query selected table with selected query
        ;;
      6)
        CURRENT_DB=""
        return
        ;;
      *)
        echo "Invalid choice"
        ;;
    esac
  done
}