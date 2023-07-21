//
//  PostTableViewCell.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/7/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //Link all the outlets in the PostVC to the cell

    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var userameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var numCommentsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        roundedBackgroundView.layer.cornerRadius = 8
        roundedBackgroundView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
