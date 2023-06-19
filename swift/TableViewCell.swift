//
//  TableViewCell.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/16.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var fullname: UILabel!
    
    @IBOutlet weak var department: UILabel!
    static let identifier = "TableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
