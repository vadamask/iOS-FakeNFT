//
//  ProgressLinePageControl.swift
//  FakeNFT
//
//  Created by Виктор on 18.11.2023.
//

import UIKit

final class ProgressLinePageControl: UIView {
    // MARK: - Properties

    var numberOfItems: Int = 0 {
        didSet {
            setupStackView()
        }
    }

    var selectedItem: Int = 0 {
        didSet {
            selectedSegmentChanged()
        }
    }

    // MARK: - Private properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func setupStackView() {
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }

        for _ in (0..<numberOfItems) {
            let segment = UIProgressView()
            segment.trackTintColor = .placeholderBackground
            segment.progressTintColor = .orange
            stackView.addArrangedSubview(segment)
        }
        selectedItem = 0
    }

    func selectedSegmentChanged() {
        for (index, subview) in stackView.arrangedSubviews.enumerated() {
            if let subview = subview as? UIProgressView {
                subview.progress = index < selectedItem ? 1 : 0
                subview.layoutIfNeeded()
            }
        }
    }

    func startAnimating() {
        guard let progressView = self.stackView.arrangedSubviews[self.selectedItem] as? UIProgressView else { return }
        progressView.progress = 1
        UIView.animate(withDuration: 3, delay: 0, options: .curveLinear) {
            progressView.layoutIfNeeded()
        }
    }
    func stopAnimating() {
        guard let progressView = self.stackView.arrangedSubviews[self.selectedItem] as? UIProgressView else { return }
        progressView.layer.sublayers?.forEach { $0.removeAllAnimations() }
    }
}
