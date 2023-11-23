//
//  ProfileDevelopersViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 15.11.2023.
//

import UIKit
import WebKit

final class DevelopersViewController: UIViewController, WKUIDelegate {
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.backButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapBackButton))
        button.tintColor = .textPrimary
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .screenBackground
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubview()
        addEdgeSwipeBackGesture()
        
        guard let myURL = URL(string: Constants.url) else { return }
        webView.load(URLRequest(url: myURL))
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = .textPrimary
        navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .screenBackground
    }
    
    func addSubview() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension DevelopersViewController {
    enum Constants {
        static let url = "https://practicum.yandex.ru/ios-developer"
    }
}
