import UIKit

class RegisterViewController: UIViewController{

    var selectedDepartment: Department?
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var hometown: UITextField!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var fullname: UITextField!
    
    @IBAction func seeAllButtonPressed(_ sender: UIButton) {

    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        registerNewEmployee()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        DBHelper.shared.createEmployeesTable()
        selectedDepartment = Department.allCases.first
    }
    
    // Validate inout and Register new employee
    func registerNewEmployee() {
    guard let name = fullname.text, !name.isEmpty,
          let hometown = hometown.text, !hometown.isEmpty,
          let selectedDepartment = selectedDepartment else {

        // Show an alert dialog if any of the required fields are missing
        let alertController = UIAlertController(title: "Error", message: "Fill in all the fields to register", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        return
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let birthdayString = dateFormatter.string(from: birthday.date)

    DBHelper.shared.registerEmployee(name: name, birthday: birthdayString, hometown: hometown, department: selectedDepartment.rawValue)
    
    // Display success message
    let successMessage = "Employee \(name) has been registered successfully"
    let successAlertController = UIAlertController(title: "Success", message: successMessage, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
        // Clear all fields
        self?.fullname.text = nil
        self?.hometown.text = nil
        self?.birthday.date = Date()
        self?.picker.selectRow(0, inComponent: 0, animated: true)
        }
    
    successAlertController.addAction(okAction)
    present(successAlertController, animated: true, completion: nil)
    }


}

// Get data for Department picker 
extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return Department.allCases.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return Department.allCases[row].rawValue
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedDepartment = Department.allCases[row]
        }
    }



