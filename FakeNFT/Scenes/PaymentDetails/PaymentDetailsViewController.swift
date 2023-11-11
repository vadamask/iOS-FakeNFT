//
//  PaymentDetailsViewController.swift
//  FakeNFT
//
//  Created by Вадим Шишков on 09.11.2023.
//
import Combine
import UIKit

private enum Section: Hashable {
    case main
}

final class PaymentDetailsViewController: UIViewController {
    let paymentView = PaymentDetailsView()
    var onSuccess: (() -> Void)?
    private lazy var dataSource = configureDataSource()
    private let viewModel: PaymentDetailsViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: PaymentDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        paymentView.delegate = self
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
        
        viewModel.$error.sink { [weak self] _ in
            let model = ErrorModel(
                message: L10n.Error.network,
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
                onSuccess?()
                let controller = SuccessfulPayment()
                controller.modalPresentationStyle = .overFullScreen
                present(controller, animated: true)
            } else {
                showAlert()
            }
        }
        .store(in: &cancellables)
    }
    
    private func showAlert() {
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
    
    private func setupUI() {
        view.backgroundColor = .screenBackground
        paymentView.collectionView.dataSource = dataSource
        paymentView.collectionView.delegate = self
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
        let screenWidth = view.bounds.width
        let cellWidth = (screenWidth - 32 - 7) / 2
        return CGSize(width: cellWidth, height: 46)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        7
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        7
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

extension PaymentDetailsViewController: PaymentDetailsViewDelegate {
    func backButtonTapped() {
        dismiss(animated: true)
    }
    
    func payButtonTapped() {
        viewModel.verifyPayment()
    }
}

extension PaymentDetailsViewController: LoadingView {}
extension PaymentDetailsViewController: ErrorView {}
