//
//  MenuTableViewCell.swift
//  swift
//
//  Created by NGUYEN DUY MINH on 2023/06/26.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    
    static let identifier = "MenuTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "MenuTableViewCell", bundle: nil)
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
