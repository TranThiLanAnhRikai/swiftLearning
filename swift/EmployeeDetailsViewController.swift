//
//  EmployeeDetailsViewController.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/19.
//

import Foundation
import UIKit


class EmployeeDetailsViewController: UIViewController {
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var hometown: UILabel!
    var employee: Employee?
    override func viewDidLoad() {
        super.viewDidLoad()
        fullname.text = employee?.fullname
        department.text = employee?.department
        birthday.text = employee?.birthday
        hometown.text = employee?.hometown
    }
}
