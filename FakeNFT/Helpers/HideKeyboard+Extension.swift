//
//  HideKeyboard+Extension.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 13.11.2023.
//

import UIKit

extension UIViewController {
    func addTapGestureToHideKeyboard(for editedView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(editedView.endEditing))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}
