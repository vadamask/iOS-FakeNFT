//
//  TextField.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 27.11.2023.
//

import UIKit

final class TextField: UITextField {
    var insets = UIEdgeInsets()

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
