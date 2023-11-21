//
//  TermsOfUse.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 21.11.2023.
//

import UIKit
import WebKit

final class TermsOfUse: UIViewController {
    private lazy var webView = WKWebView(frame: view.bounds)
    private let termsURL = "https://yandex.ru/legal/practicum_termsofuse/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        guard let url = URL(string: termsURL) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
