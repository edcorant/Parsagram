//
//  Post_Cell.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/2/20.
//

import UIKit

class Post_Cell: UITableViewCell {

    @IBOutlet weak var post_photo: UIImageView!
    @IBOutlet weak var post_owner: UILabel!
    @IBOutlet weak var post_caption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
