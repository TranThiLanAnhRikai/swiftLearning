//
//  EmployeesListController.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/16.
//


import UIKit

class EmployeesListController: UIViewController {
    
    let data: [Employee] = DBHelper.shared.getAllEmployees()


    @IBOutlet weak var tableView: UITableView!
    
    struct Employee {
        let fullname: String
        let birthday: String
        let hometown: String
        let department: String
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        print(data)
      // Do any additional setup after loading the view.
    }
}

extension EmployeesListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_tableVuew: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employee = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.fullname.text = employee.fullname
        cell.department.text = employee.department
        return cell
    }
    
    
}
