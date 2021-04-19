import UIKit

class UsersTableCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: UsersTableCellViewModel) {
        nameLabel.text = viewModel.name
    }
}
