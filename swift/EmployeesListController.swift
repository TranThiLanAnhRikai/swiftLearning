
import UIKit


class EmployeesListController: UIViewController {

//    let data: [Employee] = DBHelper.shared.getAllEmployees()
    var data: [Employee] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        loadEmployees()
        print(data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload employees data when the view appears
        loadEmployees()
    }

    func loadEmployees() {
        data = DBHelper.shared.getAllEmployees()
        tableView.reloadData()
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
