//
//  RadioboxView.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 7/3/2565 BE.
//

import UIKit
import RxSwift

class RadioboxView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    public let callCheck = PublishSubject<Bool>()
    
    var isCheck: Bool = false {
        didSet {
            checkView.isHidden = !isCheck
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("RadioboxView", owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)

        self.backgroundColor = .clear
        bgView.circleCorner = true
        bgView.borderWidth = 2
        bgView.borderColor = .black
        checkView.circleCorner = true
        checkView.isHidden = true

    }

    @IBAction func didPressView(_ sender: Any) {
        isCheck = true
        callCheck.onNext(isCheck)
    }

}
