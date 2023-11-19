//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Виктор on 12.11.2023.
//

import UIKit
import WebKit
import SnapKit

final class WebViewController: UIViewController {
    private var url: URL?

    private let webView = {
        let webView = WKWebView()
        return webView
    }()

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .screenBackground
        setupView()
        setupConstraints()

        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }

    private func setupView() {
        view.addSubview(webView)
    }

    private func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
