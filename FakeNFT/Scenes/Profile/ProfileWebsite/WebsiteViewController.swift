//
//  WebsiteViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 14.11.2023.
//

import UIKit
import WebKit

final class WebsiteViewController: UIViewController, WKUIDelegate, UIGestureRecognizerDelegate {
    let link: String?
    
    // кнопка назад
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.backButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapBackButton))
        button.tintColor = .textPrimary
        return button
    }()
    // вебвью
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .white
        return webView
    }()
    
    init(link: String? = nil) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addWebView()
        
        guard let myURL = URL(string: link ?? NetworkConstants.linkYandexPracticum) else { return }
        webView.load(URLRequest(url: myURL))
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        navigationController?.navigationBar.tintColor = .yaBlack
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = .screenBackground
    }
    
    private func addWebView() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
