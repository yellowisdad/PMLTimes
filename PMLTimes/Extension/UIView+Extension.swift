//
//  UIView+Extension.swift
//  PMLTimes
//
//  Created by Methawee Punkaew on 5/3/2565 BE.
//

import UIKit

extension UIView {
    //@IBInspectable
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    //@IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    //@IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    //@IBInspectable
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UITableView {
    func insertMultipleRows(previousCount: Int,
                            updateCount: Int,
                            section: Int = 0,
                            animation : RowAnimation = .fade){
        var indexPath : [IndexPath] {
            var x : [IndexPath] = []
            for i in previousCount...(updateCount - 1) {
                x.append(IndexPath(row: i, section: section))
            }
            return x
        }
        self.insertRows(at: indexPath, with: animation)
    }
}
