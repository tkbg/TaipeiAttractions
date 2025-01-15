//
//  TATableViewCell.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/9.
//

import UIKit

class TATableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundBorderView.backgroundColor = UIColor.clear
        self.backgroundBorderView.layer.masksToBounds = true
        self.backgroundBorderView.layer.cornerRadius = 5.0
        self.backgroundBorderView.layer.borderWidth = 2
        self.backgroundBorderView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
