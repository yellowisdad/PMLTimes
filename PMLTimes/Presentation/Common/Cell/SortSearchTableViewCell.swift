//
//  SortSearchTableViewCell.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import UIKit

class SortSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newestRadioBoxView: RadioboxView!
    @IBOutlet weak var oldestRadioBoxView: RadioboxView!
    @IBOutlet weak var relevanceRadioBoxView: RadioboxView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func check(_ sortType: SearchSort){
        switch sortType {
        case .newest:
            newestRadioBoxView.isCheck = true
            oldestRadioBoxView.isCheck = false
            relevanceRadioBoxView.isCheck = false
        case .oldest:
            newestRadioBoxView.isCheck = false
            oldestRadioBoxView.isCheck = true
            relevanceRadioBoxView.isCheck = false
        case .relevance:
            newestRadioBoxView.isCheck = false
            oldestRadioBoxView.isCheck = false
            relevanceRadioBoxView.isCheck = true
        }
        
    }
    
}
