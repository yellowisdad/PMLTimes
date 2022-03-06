//
//  DatePickerTableViewCell.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import UIKit
import RxSwift

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    
    public let callDateChanged = PublishSubject<Date>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDate(date: Date) {
        datePicker.date = date
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        callDateChanged.onNext(sender.date)
    }
}
