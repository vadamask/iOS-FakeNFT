//
//  ActionButton.swift
//  FakeNFT
//
//  Created by Виктор on 03.11.2023.
//

import UIKit
import SnapKit

/// Стили кнопок
enum ButtonType {
    /// Primary стиль
    case primary
    /// Secondary стиль
    case secondary
}

/// Основные кнопки всего проекта (стилизованные)
class ActionButton: UIControl {
    /// Заголовок
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    /// Кложура действие кнопки (не забудьте weak self)
    var action: ((ActionButton) -> Void)?

    override var isEnabled: Bool {
        didSet {
            if oldValue != isEnabled {
                updateView()
            }
        }
    }

    private lazy var titleLabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = normalTitleColor
        titleLabel.text = title
        return titleLabel
    }()

    private let type: ButtonType
    private var normalBackgroundColor: UIColor?
    private var disabledBackgroundColor: UIColor?
    private var normalTitleColor: UIColor?
    private var disabledTitleColor: UIColor?

    /// Инициализатор ActionButton
    /// - Parameters:
    ///   - title: Заголовок
    ///   - type: Тип кнопки (.primary, .secondary)
    init(title: String, type: ButtonType) {
        self.type = type
        self.title = title
        super.init(frame: .zero)
        configure()
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        layer.masksToBounds = true
        layer.cornerRadius = 16
        backgroundColor = normalBackgroundColor
        titleLabel.textColor = normalTitleColor

        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func configure() {
        switch type {
        case .primary:
            setBackgroundColor(.buttonBackground, for: .normal)
            setTitleColor(.textPrimaryInvert, for: .normal)
        case .secondary:
            setBackgroundColor(.clear, for: .normal)
            setTitleColor(.textPrimary, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = UIColor.borderColor.cgColor
        }

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func updateView() {
        if isEnabled {
            backgroundColor = normalBackgroundColor
            titleLabel.textColor = normalTitleColor
        } else {
            backgroundColor = disabledBackgroundColor != nil ? disabledBackgroundColor : normalBackgroundColor
            titleLabel.textColor = disabledTitleColor != nil ? disabledTitleColor : normalTitleColor
        }
    }

    private func setBackgroundColor(_ color: UIColor, for state: State) {
        switch state {
        case .normal:
            normalBackgroundColor = color
        case .disabled:
            disabledBackgroundColor = color
        default:
            break
        }
    }

    private func setTitleColor(_ color: UIColor, for state: State) {
        switch state {
        case .normal:
            normalTitleColor = color
        case .disabled:
            disabledTitleColor = color
        default:
            break
        }
    }

    @objc private func buttonTapped() {
        action?(self)
    }
}
