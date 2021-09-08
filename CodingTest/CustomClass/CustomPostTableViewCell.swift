//
//  CustomPostCellTableViewCell.swift
//  CodingTest
//
//  Created by Arvind Tiwari on 08/09/21.
//

import UIKit

class CustomPostTableViewCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(postData : Post){
        
        postLabel.text = postData.title
    }

}
