//
//  AttractionTableViewCell.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/9.
//

import UIKit

class AttractionTableViewCell: TATableViewCell {
    
    @IBOutlet weak var attImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
