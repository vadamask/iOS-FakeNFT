//
//  PaymentDetailsViewController.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//
import Combine
import UIKit

struct GeometrySize {
    let cellPerRow: CGFloat
    let cellHeight: CGFloat
    let cellWidth: CGFloat
    let lineSpacing: CGFloat
    let interItemSpacing: CGFloat
    let leftInset: CGFloat
    let rightInset: CGFloat
    
    init(
        cellPerRow: CGFloat,
        cellHeight: CGFloat,
        lineSpacing: CGFloat,
        interItemSpacing: CGFloat,
        leftInset: CGFloat,
        rightInset: CGFloat
    ) {
        self.cellPerRow = cellPerRow
        self.cellHeight = cellHeight
        self.lineSpacing = lineSpacing
        self.interItemSpacing = interItemSpacing
        self.leftInset = leftInset
        self.rightInset = rightInset
        
        let screenWidth = UIScreen.main.bounds.width
        self.cellWidth = (screenWidth - leftInset - rightInset - interItemSpacing) / cellPerRow
    }
}

final class PaymentDetailsViewController: UIViewController {
    private enum Section: Hashable {
        case main
    }
    private let paymentView = PaymentDetailsView()
    private lazy var dataSource = configureDataSource()
    private let viewModel: PaymentDetailsViewModel
    private var cancellables: Set<AnyCancellable> = []
    private let sizes = GeometrySize(
        cellPerRow: 2,
        cellHeight: 46,
        lineSpacing: 7,
        interItemSpacing: 7,
        leftInset: 16,
        rightInset: 16
    )
    
    init(viewModel: PaymentDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = paymentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCurrencies()
    }
    
    private func bind() {
        viewModel.currencies.sink { [weak self] currencies in
            self?.applySnapshot(animate: false, values: currencies)
        }
        .store(in: &cancellables)
        
        viewModel.$error.sink { [weak self] error in
            guard let error else { return }
            
            let model = ErrorModel(
                message: L10n.Error.network + error.localizedDescription,
                actionText: L10n.Error.repeat
            ) { [weak self] in
                self?.viewModel.loadCurrencies()
            }
            self?.showError(model)
        }
        .store(in: &cancellables)
        
        viewModel.$isLoading.sink { [weak self] isLoading in
            guard let isLoading else { return }
            if isLoading {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }
        .store(in: &cancellables)
        
        viewModel.$selectedCurrencyID.sink { [weak self] id in
            guard let self else { return }
            
            if id != nil {
                self.paymentView.payButton.isEnabled = true
                self.paymentView.payButton.backgroundColor = .buttonBackground
            } else {
                self.paymentView.payButton.isEnabled = false
                self.paymentView.payButton.backgroundColor = .yaGray
            }
        }
        .store(in: &cancellables)
        
        viewModel.$isPaymentSuccess.sink { [weak self] isSuccess in
            guard let self, let isSuccess else { return }
            
            if isSuccess {
                viewModel.paymentDidTapped()
            } else {
                showAlertWithPaymentFail()
            }
        }
        .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.backgroundColor = .screenBackground
        navigationItem.title = L10n.Cart.PaymentScreen.topBarTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Asset.backButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonDidTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .borderColor
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setDelegates() {
        paymentView.collectionView.dataSource = dataSource
        paymentView.collectionView.delegate = self
        paymentView.delegate = self
    }
    
    @objc private func backButtonDidTapped() {
        viewModel.backButtonDidTapped()
    }
}

// MARK: - UICollectionViewDiffableDataSource

extension PaymentDetailsViewController {
    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Currency> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Currency>(
            collectionView: paymentView.collectionView
        ) { [weak self] _, indexPath, _ -> UICollectionViewCell in
            guard let self else { return UICollectionViewCell() }
            
            if let cell = self.paymentView.collectionView.dequeueReusableCell(
                withReuseIdentifier: CurrencyCell.defaultReuseIdentifier,
                for: indexPath
            ) as? CurrencyCell {
                cell.configure(with: viewModel.currencies.value[indexPath.row])
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        return dataSource
    }
    
    private func applySnapshot(animate: Bool, values: [Currency]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Currency>()
        snapshot.appendSections([.main])
        snapshot.appendItems(values, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PaymentDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: sizes.cellWidth,
            height: sizes.cellHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        sizes.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        sizes.interItemSpacing
    }
}

// MARK: - CollectionViewDelegate

extension PaymentDetailsViewController {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.indexPathsForVisibleItems.forEach { current in
            let cell = collectionView.cellForItem(at: current) as? CurrencyCell
            cell?.isSelect = indexPath == current
        }
        viewModel.currencyDidTapped(at: indexPath)
    }
}

// MARK: - PaymentDetailsViewDelegate

extension PaymentDetailsViewController: PaymentDetailsViewDelegate {
    func payButtonTapped() {
        viewModel.verifyPayment()
    }
    
    func linkTapped() {
        viewModel.linkDidTapped()
    }
}

// MARK: - ErrorView

extension PaymentDetailsViewController: ErrorView {
    private func showAlertWithPaymentFail() {
        let alertController = UIAlertController(
            title: L10n.Error.insufficientFunds,
            message: nil,
            preferredStyle: .alert
        )
        let repeatAction = UIAlertAction(
            title: L10n.Error.repeat,
            style: .default
        ) { [weak self] _ in
            self?.viewModel.verifyPayment()
        }
        let cancelAction = UIAlertAction(
            title: L10n.Error.cancel,
            style: .cancel
        )
        
        alertController.addAction(repeatAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}


extension PaymentDetailsViewController: LoadingView {}
