//
//  CustomTableViewCell.swift
//  testOmdb
//
//  Created by shrutesh sharma on 26/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var year: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        self.containerView.layer.cornerRadius = 5.0
        self.movieImage.layer.cornerRadius = 5.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.3
        self.containerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.containerView.layer.shadowRadius = 3.0
        self.containerView.layer.shadowPath = UIBezierPath(rect: self.containerView.bounds).cgPath
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
