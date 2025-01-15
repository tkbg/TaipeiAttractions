//
//  NewTableViewCell.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/9.
//

import UIKit

class NewTableViewCell: TATableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
