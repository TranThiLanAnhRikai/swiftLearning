
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


    }
    override func layoutSubviews() {
           super.layoutSubviews()
           
           // Apply elevation effect
           layer.masksToBounds = false
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.5
           layer.shadowOffset = CGSize(width: 0, height: 2)
           layer.shadowRadius = 4
           
           // Apply border
           layer.borderWidth = 1
           layer.borderColor = UIColor.gray.cgColor
           
           // Apply border radius
           layer.cornerRadius = 8
       }
    
}
