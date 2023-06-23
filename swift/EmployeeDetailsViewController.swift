
import Foundation
import UIKit

protocol passData {
    func updateRow(updatedIndexPath: [IndexPath])
}
class EmployeeDetailsViewController: UIViewController {
  
    
    var employee: Employee?
    var delegate: passData!
    var selectedRow: Int?
    @IBOutlet weak var buttons: UIStackView!
    var selectedDepartment: Department?
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var deptPicker: UIPickerView!
    @IBOutlet weak var department: UITextField!
    
    @IBOutlet weak var hometown: UITextField!
    @IBOutlet weak var birthday: UITextField!
    
    @IBOutlet weak var picker: UIDatePicker!
    // Delete Button
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBAction func deleteButtonPressed(_ sender: Any) {
        // Display confirmation alert dialog
               let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this employee?", preferredStyle: .alert)

               // Create "Cancel" action
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alert.addAction(cancelAction)

               // Create "Yes" action
               let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                   self.deleteEmployee()
               }
               alert.addAction(yesAction)

               // Present the alert dialog
               present(alert, animated: true, completion: nil)
           }

           func deleteEmployee() {
               // Perform deletion logic here
               DBHelper.shared.deleteEmployee(id: employee!.id)

               // Go back to EmployeesListViewController
               navigationController?.popViewController(animated: true)
           }
    
    // Cancel Button
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        print("cancel button pressed")
        fullname.text = employee?.fullname
        department.isHidden = false
        department.text = employee?.department
        birthday.isHidden = false
        birthday.text = employee?.birthday
        hometown.text = employee?.hometown
        
        // Hide the picker and show the corresponding buttons
        deptPicker.isHidden = true
        editDeptButton.isHidden = false
        picker.isHidden = true
        editBdButton.isHidden = false
        hometown.isUserInteractionEnabled = false
        editHTButton.isHidden = false
        fullname.isUserInteractionEnabled = false
        editFnButton.isHidden = false
    }
    
    // Save Button
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let employeeID = employee?.id,
                  let updatedName = fullname.text,
                  let updatedHometown = hometown.text,
              let updatedDepartment = selectedDepartment?.rawValue else {
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let updatedBirthday = dateFormatter.string(from: picker.date)
    

            // Call the updateEmployee function to update the employee
        DBHelper.shared.updateEmployee(id: employeeID, name: updatedName, birthday: updatedBirthday, hometown: updatedHometown, department: updatedDepartment)

            
            // Display the updated information
            fullname.text = updatedName
            department.isHidden = false
            department.text = updatedDepartment
            birthday.isHidden = false
            birthday.text = updatedBirthday
            hometown.text = updatedHometown
            
            // Hide the picker and show the corresponding buttons
            deptPicker.isHidden = true
            editDeptButton.isHidden = false
            picker.isHidden = true
            editBdButton.isHidden = false
            hometown.isUserInteractionEnabled = false
            editHTButton.isHidden = false
            fullname.isUserInteractionEnabled = false
            editFnButton.isHidden = false
        
        //
        let indexPath = IndexPath(item: selectedRow!, section: 0)
        print(selectedRow!)
        print(indexPath)
        print(delegate)
        delegate.updateRow(updatedIndexPath: [indexPath])
            
      

    }

    //Edit Dept Button
    @IBOutlet weak var editDeptButton: UIButton!
    @IBAction func editDeptButtonPressed(_ sender: Any) {
        buttons.isHidden = false
        editDeptButton.isHidden = true
        department.isHidden = true
        deptPicker.isHidden = false
    }
    
    //Edit Fullname Button
    @IBOutlet weak var editFnButton: UIButton!
    @IBAction func editFnButtonPressed(_ sender: Any) {
        buttons.isHidden = false
        fullname.becomeFirstResponder()
        editFnButton.isHidden = true
        fullname.isUserInteractionEnabled = true
    }

    
    // Edit Birthday Button
    @IBOutlet weak var editBdButton: UIButton!
    @IBAction func editBdButtonPressed(_ sender: Any) {
        buttons.isHidden = false
        birthday.isHidden = true
        picker.isHidden = false
        editBdButton.isHidden = true
    }
    
    // Edit Hometown Button
    @IBOutlet weak var editHTButton: UIButton!
    @IBAction func editHTButtonPressed(_ sender: Any) {
        buttons.isHidden = false
        hometown.isUserInteractionEnabled = true
        hometown.becomeFirstResponder()
        editHTButton.isHidden = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fullname.text = employee?.fullname
        department.text = employee?.department
        birthday.text = employee?.birthday
        hometown.text = employee?.hometown
        
        if let birthdayString = employee?.birthday {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                if let birthdayDate = dateFormatter.date(from: birthdayString) {
                    picker.setDate(birthdayDate, animated: false)
                }
            }
        
        deptPicker.dataSource = self
        deptPicker.delegate = self
        selectedDepartment = Department.allCases.first
        hometown.isUserInteractionEnabled = false
        fullname.isUserInteractionEnabled = false
        department.isUserInteractionEnabled = false
        birthday.isUserInteractionEnabled = false
        navigationItem.setHidesBackButton(true, animated: false)
    }
}

extension EmployeeDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
