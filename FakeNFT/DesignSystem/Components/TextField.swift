//
//  TextField.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 27.11.2023.
//

import UIKit
// Расширение для замены стандартного UITextField. Создание текстовых полей с настраиваемыми отступами вокруг текста
final class TextField: UITextField {
    var insets: UIEdgeInsets = UIEdgeInsets()
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
