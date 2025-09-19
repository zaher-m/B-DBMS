#!/bin/bash
source modules/database_ops.sh
source modules/table_ops.sh
source modules/query_ops.sh

CURRENT_DB=""
show_main_menu() {
  echo "DBMS Menu:"
  echo "|||||||||||||||||||||"
  echo "1. Create Database"
  echo "2. List Databases"
  echo "3. Connect to Database"
  echo "4. Drop Database"
  echo "5. Exit"
}
show_sub_menu() {
  echo "Database: $CURRENT_DB"
  echo "|||||||||||||||||||||"
  echo "1. Create Table"
  echo "2. Drop Table"
  echo "3. Insert Record"
  echo "4. Update Record"
  echo "5. Delete Record"
  echo "6. Query Table"
  echo "7. Back to Main Menu"
}

main_loop() {
  while true; do
    show_main_menu
    read -p "Choice: " choice
    case $choice in
      1)
        read -p "Enter database name: " db_name
        create_database "$db_name"
        echo "database $db_name created successfully!"
        ;;
      2)
        list_databases
        ;;
      3)
        read -p "Enter database name: " db_name
        CURRENT_DB=$(connect_database "$db_name")
        if [ $? -eq 0 ]; then
          sub_menu_loop
        fi
        ;;
      4)
        read -p "Enter database name: " db_name
        drop_database "$db_name"
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
        read -p "Enter comma-separated fields (ID(PK),Name,Age,etc): " fields
        create_table "$CURRENT_DB" "$table_name" "$fields"
        ;;
      2)
        read -p "Enter table name: " table_name
        drop_table "$1" "$2"
      3)
        read -p "Enter table name: " table_name
        read -p "Enter values: " values
        insert_record "$CURRENT_DB" "$table_name" "$values"
        ;;
      4)
        read -p "Enter table name: " table_name
        read -p "Enter ID to update: " id
        read -p "Enter new values (comma-separated): " values
        update_record "$CURRENT_DB" "$table_name" "$id" "$values"
        ;;
      5)
        read -p "Enter table name: " table_name
        read -p "Enter ID to delete: " id
        delete_record "$CURRENT_DB" "$table_name" "$id"
        ;;
      6)
        read -p "Enter table name: " table_name
        read -p "Enter query (*  for select all): " query
        select_all "$CURRENT_DB" "$table_name"
        ;;
      7)
        CURRENT_DB=""
        return
        ;;
      *)
        echo "Invalid choice"
        ;;
    esac
  done
}