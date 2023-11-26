//
//  AlertModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 26.11.2023.
//

import UIKit

struct AlertModel {
    var title: String
    var message: String
    var textField: Bool
    var placeholder: String
    var buttonText: String
    var styleAction: UIAlertAction.Style
    var completion: ((UIAlertAction) -> Void)?
}
