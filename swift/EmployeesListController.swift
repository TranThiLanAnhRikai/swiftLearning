//
//  EmployeesListController.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/16.
//


import UIKit


class EmployeesListController: UIViewController {
    struct Employee {
        let fullname: String
        let birthday: String
        let hometown: String
        let department: String
        
    }
    
    let data: [Employee] = DBHelper.shared.getAllEmployees()


    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
    
      // Do any additional setup after loading the view.
    }
}

extension EmployeesListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "employeeDetails") as! EmployeeDetailsViewController
        let employee = data[indexPath.row]
        vc.employee = employee
        navigationController?.pushViewController(vc, animated: true)
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
