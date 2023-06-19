//
//  DBHelper.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/16.
//


import Foundation



import SQLite

class DBHelper {
    static let shared = DBHelper()

    private let db: Connection?

    private init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let databasePath = documentsPath.appendingPathComponent("employees.db")

        do {
            db = try Connection(databasePath)
        } catch {
            print("Error connecting to database: \(error)")
            db = nil
        }
    }

    func createEmployeesTable() {
            if let db = db {
                let employees = Table("employees")
                let id = Expression<Int>("id")
                let name = Expression<String>("name")
                let birthday = Expression<String>("birthday")
                let hometown = Expression<String>("hometown")
                let department = Expression<String>("department")

                do {
                    try db.run(employees.create { table in
                        table.column(id, primaryKey: true)
                        table.column(name)
                        table.column(birthday)
                        table.column(hometown)
                        table.column(department)
                    })
                    print("Employees table created successfully")
                } catch {
                    print("Error creating employees table: \(error)")
                }
            } else {
                print("Database connection is not available")
            }
        }
    func registerEmployee(name: String, birthday: String, hometown: String, department: String) {
        if let db = db {
            let employees = Table("employees")
            let nameColumn = Expression<String>("name")
            let birthdayColumn = Expression<String>("birthday")
            let hometownColumn = Expression<String>("hometown")
            let departmentColumn = Expression<String>("department")

            do {
                let insert = employees.insert(nameColumn <- name,
                                              birthdayColumn <- birthday,
                                              hometownColumn <- hometown,
                                              departmentColumn <- department)
                let rowId = try db.run(insert)
                print("Inserted employee with ID: \(rowId)")
            } catch {
                print("Error inserting employee: \(error)")
            }
        } else {
            print("Database connection is not available")
        }
    }
    
    func getAllEmployees() -> [EmployeesListController.Employee] {
            var employees: [EmployeesListController.Employee] = []
            
            do {
                let employeesTable = Table("employees")
                let fullname = Expression<String>("name")
                let birthday = Expression<String>("birthday")
                let hometown = Expression<String>("hometown")
                let department = Expression<String>("department")
                
                // Fetch all rows from the employees table
                let query = employeesTable.select(fullname, birthday, hometown, department)
                let rows = try db?.prepare(query)
                
                if let rows = rows {
                    for row in rows {
                        let employee = EmployeesListController.Employee(
                            fullname: row[fullname],
                            birthday: row[birthday],
                            hometown: row[hometown],
                            department: row[department]
                        )
                        employees.append(employee)
                    }
                }
                
            } catch {
                print("Failed to fetch employees: \(error)")
            }

            return employees
        }


}
