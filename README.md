# Bash Shell Script Database Management System (DBMS)

## Project Overview

This project develops a lightweight, file-based **Database Management System (DBMS)** using Bash scripting, stores data on the hard disk as text files, with each database represented as a directory containing table files in a CSV format. Performing basic database operations through simple CLI and workflow.

---

## Project Features (Main Menu)

The CLI menu provides the following options:

1. **Create Database**: Create a new database.
2. **List Databases**: Display all available databases.
3. **Connect to Databases**: Select/use a specific database.
4. **Drop Database**: Delete a specific database and its contents.

When connected to a database, a sub-menu allows table-level operations (create table, list tables, insert record, query data, delete table, etc).

---

## Project Decomposition

The project is broken into **5 components** for modularity and clarity. Each component is responsible for specific functionality, implemented as separate Bash scripts or functions that interact through function calls and file system operations.

1. **Main CLI**: Provides the menu interface and orchestrates all operations.
2. **Database Management**: Handles creation, listing, and deletion of databases.
3. **Data Storage**: Manages the physical storage of databases and tables on disk.
4. **Table and Record Operations**: Manages tables and records within a selected database (sub-menu operations).
5. **Query**: For retrieving data from tables with basic filtering.

### Component Structure

The Main CLI is the entry point (orchestrator) that calling other modules. Modules interact with the file system via the Data Storage Module.

```plaintext
+-------------------+
|   Main CLI Module |
|   (dbms.sh)       |
|   Menu Loop       |
|   Parses Input    |
+-------------------+
         |
         | Calls Functions
         v
+-----------------------------------+
| Database Management Module        |
| - Create Database                 |
| - List Databases                  |
| - Drop Database                   |
| - Connect to Database (Sub-menu)  |
+-----------------------------------+
         |                          |
         | Uses                     | Connects to Sub-menu
         v                          v
+-------------------+       +-------------------+
| Data Storage      |       | Table & Record    |
| Module            |<----->| Operations Module |
| - File I/O        |       | - Create Table    |
| - Directory Mgmt  |       | - Insert/Update   |
| - CSV Parsing     |       | - Delete Record   |
+-------------------+       +-------------------+
                            | Uses
                            v
                           +-------------------+
                           | Query Module      |
                           | - Select All      |
                           | - Select Where    |
                           | - Format Output   |
                           +-------------------+
```

---

## Directory Structure

```plaintext
dbms_project/
├── dbms.sh                   # Main CLI script
├── modules/
│   ├── data_storage.sh       # Data storage module
│   ├── database_ops.sh       # Database management module
│   ├── table_ops.sh   # Table and record operations module
│   ├── query_ops.sh          # Query module
└── DATA/           # Database storage directory
```
