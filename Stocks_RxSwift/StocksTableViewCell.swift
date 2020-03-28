//
//  StocksTableViewCell.swift
//  Stocks_RxSwift
//
//  Created by Scott Kerkove on 3/25/20.
//  Copyright © 2020 Scott Kerkove. All rights reserved.
//

import UIKit
import QuartzCore

class StocksTableViewCell: UITableViewCell {
    
    var stockVM = StocksViewModel()
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changesLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpCell()
        // Configure the view for the selected state
    }
     
    func setUpCell(){
        changesLabel.layer.cornerRadius = changesLabel.frame.size.height / 8
        changesLabel.layer.masksToBounds = true
        let border = CALayer()
        border.backgroundColor = UIColor.red.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
        }
    
    
}
