//
//  TAHeaderFooterView.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit

class TAHeaderFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var backgroundBorderView: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var pageButton: UIButton!    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundBorderView.backgroundColor = UIColor(named: "HeaderViewBGColor")
        self.backgroundBorderView.layer.masksToBounds = true
        self.backgroundBorderView.layer.cornerRadius = 5.0
        self.backgroundBorderView.layer.borderWidth = 2
        self.backgroundBorderView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        
        self.leftButton.tintColor = UIColor(named: "ButtonTintColor")
        self.rightButton.tintColor = UIColor(named: "ButtonTintColor")
        
        self.pageLabel.textColor = UIColor(named: "HeaderViewPageTextColor")
        
        self.moreButton.tintColor = UIColor(named: "ButtonTintColor")
        
        self.titleLabel.textColor = UIColor(named: "TextColor")
    }
}
