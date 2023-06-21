
import Foundation
import UIKit
import iOSDropDown

class SearchViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fullname: UITextField!
    
    @IBOutlet weak var dateTo: UIDatePicker!
    @IBOutlet weak var dateFrom: UIDatePicker!
    @IBOutlet weak var htDropdown: DropDown!
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var deptDropdown: DropDown!
    var data: [Employee] = []
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchEmployees()
        tableView.reloadData()
    }
    
    @IBAction func dateFromValueChanged(_ sender: UIDatePicker) {
        dateTo.minimumDate = sender.date
    }
    
    let hometowns = DBHelper.shared.getHometowns()
    override func viewDidLoad() {
            super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        htDropdown.optionArray = hometowns
        deptDropdown.optionArray = Department.allCases.map { $0.rawValue }
        htDropdown.text = htDropdown.optionArray.first
        htDropdown.arrowSize = 10
        deptDropdown.text = deptDropdown.optionArray.first
        deptDropdown.arrowSize = 10
        }
        


    func searchEmployees() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"

        let dateFromValue = dateFormatter.string(from: dateFrom.date)
        let dateToValue = dateFormatter.string(from: dateTo.date)
        let fullNameValue = fullname.text ?? ""
        let hometownValue = htDropdown.text ?? ""
        let departmentValue = deptDropdown.text ?? ""
        data = DBHelper.shared.searchEmployees(fullname: fullNameValue, dateFrom: dateFromValue, dateTo: dateToValue, hometown: hometownValue, department: departmentValue)
        if data.isEmpty {
            let alert = UIAlertController(title: "No User Found", message: "No employees matching the search criteria were found.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            fullname.text = ""
            dateFrom.date = Date()
            dateTo.date = Date()
            htDropdown.text = htDropdown.optionArray.first
            deptDropdown.text = deptDropdown.optionArray.first
        }

    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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

