//
//  AttImageTableViewCell.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/11.
//

import UIKit

class AttImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
