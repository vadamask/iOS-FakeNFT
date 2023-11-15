//
//  UserWebViewController.swift
//  FakeNFT
//
//  Created by Artem Adiev on 12.11.2023.
//

import UIKit
import WebKit

final class UserWebViewController: UIViewController {
    // MARK: - Properties
    private let webView: WKWebView
    private let url: URL

    // MARK: - Init
    init(url: URL) {
        self.webView = WKWebView()
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) не реализован")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }

    // MARK: - Setup UI
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.frame = view.bounds
    }
}
