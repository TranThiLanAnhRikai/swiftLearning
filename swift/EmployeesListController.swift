import UIKit
import iOSDropDown

class EmployeesListController: UIViewController, passData{
    
    
    var data: [Employee] = []
    var selectedEmployee: Employee?
    //    var selectedRow: Int?
    var selectedIndexPath: IndexPath?
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var displayButton: UIButton!
    var categoryList = ["Fullname", "Birthday"]
    var orderList = ["Ascending", "Descending"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        loadEmployees()
        
        let fullnameAction = UIAction(title: "Fullname") { [weak self] _ in
            self?.updateButtonTitle("Fullname")
        }
        
        let birthdayAction = UIAction(title: "Birthday") { [weak self] _ in
            self?.updateButtonTitle("Birthday")
        }
        
        let categoryMenu = UIMenu(title: "", children: [fullnameAction, birthdayAction])
        categoryButton.showsMenuAsPrimaryAction = true
        categoryButton.menu = categoryMenu
        
        
        let ascendingAction = UIAction(title: "Ascending") { [weak self] _ in
            self?.updateOrderButtonTitle("Ascending")
        }
        
        let descendingAction = UIAction(title: "Descending") { [weak self] _ in
            self?.updateOrderButtonTitle("Descending")
        }
        
        let orderMenu = UIMenu(title: "", children: [ascendingAction, descendingAction])
        orderButton.showsMenuAsPrimaryAction = true
        orderButton.menu = orderMenu

        
        
    }
    
    @IBAction func displayButtonPressed(_ sender: Any) {
        sortEmployees()
    }
    func updateButtonTitle(_ title: String) {
        categoryButton.setTitle(title, for: .normal)
    }
    
    func updateOrderButtonTitle(_ title: String) {
        orderButton.setTitle(title, for: .normal)
    }

    func loadEmployees() {
        data = DBHelper.shared.getAllEmployees()
        tableView.reloadData()
    }
    
    func sortEmployees() {
        let category = categoryButton.title(for: .normal)
        let order = orderButton.title(for: .normal)
        
        // Get the sorted employees list based on the selected category and order
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        if category == "Fullname" {
            if order == "Ascending" {
                data.sort { $0.fullname.localizedStandardCompare($1.fullname) == .orderedAscending }
            } else {
                data.sort { $0.fullname.localizedStandardCompare($1.fullname) == .orderedDescending }
            }
        } else if category == "Birthday" {
            if order == "Ascending" {
                data = DBHelper.shared.getAllEmployees().sorted { employee1, employee2 in
                    guard let date1 = dateFormatter.date(from: employee1.birthday),
                          let date2 = dateFormatter.date(from: employee2.birthday) else {
                        return false
                    }
                    return date1 < date2
                }
            } else {
                data = DBHelper.shared.getAllEmployees().sorted { employee1, employee2 in
                    guard let date1 = dateFormatter.date(from: employee1.birthday),
                          let date2 = dateFormatter.date(from: employee2.birthday) else {
                        return false
                    }
                    return date1 > date2
                }
            }
        }
        
        tableView.reloadData()
    }
    func updateRows() {
        loadEmployees() // Update the data array with the latest employees
    }
}
    extension EmployeesListController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "employeeDetails") as! EmployeeDetailsViewController
            let employee = data[indexPath.row]
            vc.employee = employee
            vc.selectedRow = indexPath.row
            selectedIndexPath = indexPath
            vc.delegate = self
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
