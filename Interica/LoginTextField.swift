//
//  LoginTextField.swift
//  Disigners
//
//  Created by RX Group on 12.10.2022.
//

import UIKit

class LoginTextField: UITextField {

    fileprivate let paddingPlaceholder = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addToolBar()
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(displayP3Red: 215/255, green: 215/255, blue: 215/255, alpha: 1).cgColor
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingPlaceholder)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingPlaceholder)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingPlaceholder)
    }
}
