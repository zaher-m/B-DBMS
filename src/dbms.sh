
CURRENT_DB=""
show_main_menu() {
  echo "DBMS Menu:"
  echo "1. Create Database"
  echo "2. List Databases"
  echo "3. Connect to Database"
  echo "4. Drop Database"
  echo "5. Exit"
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
