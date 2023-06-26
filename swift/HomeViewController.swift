//
//  HomeViewController.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/26.
//

import Foundation
import UIKit
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var isSideViewOpen: Bool = false
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var menuItems = ["Register", "List", "Search"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell: MenuTableViewCell = sidebar.dequeueReusableCell(withIdentifier: "menucell") as! MenuTableViewCell
        menuCell.lbl.text = menuItems[indexPath.row]
        return menuCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "register") as! RegisterViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "list") as! EmployeesListController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "search") as! SearchViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
   
    @IBOutlet weak var sidebar: UITableView!
    
    @IBOutlet weak var sideview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sidebar.dataSource = self
        sidebar.delegate = self
        sidebar.register(MenuTableViewCell.nib(), forCellReuseIdentifier: MenuTableViewCell.identifier)
//        sideview.isHidden = true
//        isSideViewOpen = false
        menuButton.target = self
                menuButton.action = #selector(handleBarButtonItemTapped)
            }
            
            @objc func handleBarButtonItemTapped() {
                // Handle the bar button item action here

//                isSideViewOpen = true
                sideview.isHidden = false
        
            }
}
