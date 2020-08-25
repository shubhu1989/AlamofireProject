//
//  TableViewCell.swift
//  SegDemoInSwift
//
//  Created by CitySpidey on 6/18/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet var profileConsHeight: NSLayoutConstraint!
    @IBOutlet var profileImage: customImageView!
    
    var users : LiveNewsModel!{
        didSet{
            label1.text = users.author
            label2.text = users.title
            label3.text = users.description
            
            profileImage.loadImageUsingUrlString(urlString:users.urlToImage!)
            
            let width = profileImage.image?.size.width
            let height = profileImage.image?.size.height
            
            if(profileImage?.image != nil){
                let hRatio = height! / width!
                let newImageHeight = hRatio * UIScreen.main.bounds.width
                profileConsHeight.constant = newImageHeight
                profileImage.layoutIfNeeded()
                
                contentView.layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
