//
//  PaymentDetailsViewController.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//

import UIKit

final class PaymentDetailsViewController: UIViewController {
    let paymentView = PaymentView()
    
    override func loadView() {
        self.view = paymentView
    }
}
