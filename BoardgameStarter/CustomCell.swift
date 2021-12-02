//
//  CustomCell.swift
//  BoardgameStarter
//
//  Created by Rasmus Sejer on 30/05/2021¢.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    @IBOutlet weak var customCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUILabel(label: customCellLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    func configureUILabel(label: UILabel){
        label.textColor = .white
        label.backgroundColor = UIColor.darkGray
        
        label.layer.masksToBounds = false
        label.layer.cornerRadius = 10
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 4.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        
    }
}
