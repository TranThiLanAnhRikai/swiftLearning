
import Foundation

import SQLite

class DBHelper {
    static let shared = DBHelper()

    private let db: Connection?

    // Create database
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
    
    // Create table
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
    
    // Register employee
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
    
    //Get all employees
    func getAllEmployees() -> [Employee] {
            var employees: [Employee] = []
            
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
                        let employee = Employee(
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
    
    // Get all hometowns from database for dropdown at SearchView
    func getHometowns() -> [String] {
        var hometowns: Set<String> = []

        if let db = db {
            let employeesTable = Table("employees")
            let hometown = Expression<String>("hometown")

            do {
                // Fetch all rows from the employees table
                let query = employeesTable.select(hometown)
                let rows = try db.prepare(query)

                for row in rows {
                    hometowns.insert(row[hometown])
                }
            } catch {
                print("Failed to fetch hometowns: \(error)")
            }
        } else {
            print("Database connection is not available")
        }

        return Array(hometowns)
    }
    
    // Search employees
    func searchEmployees(fullname: String?, dateFrom: String, dateTo: String, hometown: String, department: String) -> [Employee] {
        var employees: [Employee] = []
        
        do {
            let employeesTable = Table("employees")
            let fullnameColumn = Expression<String>("name")
            let birthdayColumn = Expression<String>("birthday")
            let hometownColumn = Expression<String>("hometown")
            let departmentColumn = Expression<String>("department")
            
            // Start with a base query to fetch all rows from the employees table
            var query = employeesTable.select(fullnameColumn, birthdayColumn, hometownColumn, departmentColumn)
            
            // Check if fullname is provided and add it as a condition
            if let fullname = fullname, !fullname.isEmpty {
                // Use the "LIKE" operator to perform a case-insensitive search for names containing the provided letters
                query = query.filter(fullnameColumn.like("%\(fullname)%", escape: "\\"))
            }
            
            // Add date range condition based on dateFrom and dateTo parameters
            query = query.filter(birthdayColumn >= dateFrom && birthdayColumn <= dateTo)
            
            // Add hometown condition
            query = query.filter(hometownColumn == hometown)
            
            // Add department condition
            query = query.filter(departmentColumn == department)
      
            // Fetch the filtered rows from the employees table
            let rows = try db?.prepare(query)
            
            if let rows = rows {
                for row in rows {
                    let employee = Employee(
                        fullname: row[fullnameColumn],
                        birthday: row[birthdayColumn],
                        hometown: row[hometownColumn],
                        department: row[departmentColumn]
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
