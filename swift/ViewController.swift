//
//  ViewController.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/16.
//

import UIKit

class ViewController: UIViewController{

    var selectedDepartment: Department?
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var seeAllButton: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var hometown: UITextField!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var fullname: UITextField!
    
    
    @IBAction func seeAllButtonPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "goToList", sender: self)

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
        // Do any additional setup after loading the view.
    }
    
    func registerNewEmployee() {
        guard let name = fullname.text,
              let hometown = hometown.text,
              let selectedDepartment = selectedDepartment else {

            // Handle the case where any of the required fields are missing
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdayString = dateFormatter.string(from: birthday.date)


        DBHelper.shared.registerEmployee(name: name, birthday: birthdayString, hometown: hometown, department: selectedDepartment.rawValue)
       
        
    }

}
    extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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



