//
//  TextFieldWithInsets.swift
//  Bonfire
//
//  Created by Kurt Invernon on 24/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import UIKit

class TextFieldWithInsets: UITextField {

    let inset = CGFloat(20.0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }

}
