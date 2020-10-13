//
//  Comment_Cell.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/12/20.
//

import UIKit

class Comment_Cell: UITableViewCell {
    
    @IBOutlet weak var commentator: UILabel!
    @IBOutlet weak var comment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
