//
//  ProfileMyNFTViewController.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 15.11.2023.
//

import UIKit

final class MyNFTViewController: UIViewController, UIGestureRecognizerDelegate {
    private let viewModel: MyNFTViewModelProtocol
    
    private lazy var myNFTTable: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyNFTCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    // кнопка сортировки
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Asset.sortButton.image,
            style: .plain,
            target: self,
            action: #selector(didTapSortButton))
        button.tintColor = .textPrimary
        return button
    }()
    // лейбл при отсутствии нфт
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Profile.emptyNFTLabel // У вас ещё нет NFT
        label.font = .bodyBold17
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: MyNFTViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupView()
        setupConstraints()
        addEdgeSwipeBackGesture()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .screenBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkStoredSort()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func bind() {
        viewModel.onChange = { [weak self] in
            guard let self = self else { return }
            self.myNFTTable.reloadData()
            myNFTTable.isHidden = viewModel.checkNoNFT()
            emptyLabel.isHidden = !viewModel.checkNoNFT()
            navigationItem.rightBarButtonItem?.isEnabled = !viewModel.checkNoNFT()
            navigationItem.rightBarButtonItem?.image = viewModel.setImageForButton()
            
            title = viewModel.setTitle()
        }
        
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(
                title: "Ошибка, нет интернета",
                message: error.localizedDescription,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSortButton() {
        let alert = UIAlertController(
            title: nil,
            message: "Сортировка",
            preferredStyle: .actionSheet
        )
        let sortByPriceAction = UIAlertAction(title: "По цене", style: .default) { [weak self] _ in
            self?.viewModel.sort = .price
            self?.viewModel.saveSortOrder(order: .price)
        }
        let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
            self?.viewModel.sort = .rating
            self?.viewModel.saveSortOrder(order: .rating)
        }
        let sortByNameAction = UIAlertAction(title: "По названию", style: .default) { [weak self] _ in
            self?.viewModel.sort = .name
            self?.viewModel.saveSortOrder(order: .name)
        }
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alert.addAction(sortByPriceAction)
        alert.addAction(sortByRatingAction)
        alert.addAction(sortByNameAction)
        alert.addAction(closeAction)
        
        present(alert, animated: true)
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Мои NFT"
        view.backgroundColor = .screenBackground
        setupEmptyLabel()
    }
    
    func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupConstraints() {
        view.addSubview(myNFTTable)
        
        NSLayoutConstraint.activate([
            myNFTTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myNFTTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myNFTTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myNFTTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MyNFTViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myNFTs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyNFTCell = tableView.dequeueReusableCell()
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        guard !viewModel.myNFTs.isEmpty else { return MyNFTCell() }
        let myNFT = viewModel.myNFTs[indexPath.row]
        
        let model = MyNFTCell.CellModel(
            image: myNFT.images.first ?? "",
            name: myNFT.name,
            rating: myNFT.rating,
            author: viewModel.authors[myNFT.author] ?? "",
            price: myNFT.price,
            isFavorite: viewModel.likedIDs.contains(myNFT.id),
            id: myNFT.id
        )
        
        cell.tapAction = { [weak self] in
            let tappedNFT = self?.viewModel.myNFTs.filter({ $0.id == myNFT.id }).first
            if let tappedNFT = tappedNFT {
                self?.viewModel.notificationMyNFTliked(myNFTs: tappedNFT)
                self?.viewModel.toggleLikeFromMyNFT(id: tappedNFT.id) }
        }
        cell.configureCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension MyNFTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let removeButton = UIContextualAction(style: .destructive,
                                              title: "Удалить") { [weak self] _, _, _ in
            guard let self else { return }
            let alertController = UIAlertController(title: "Вы уверены что хотите удалить этот NFT?",
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
                guard let self else { return }
                self.viewModel.deleteNFT(atRow: indexPath.row)
            }
            let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { _ in
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
        removeButton.backgroundColor = UIColor.yaRed.withAlphaComponent(0)
        let config = UISwipeActionsConfiguration(actions: [removeButton])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        tableView.subviews.forEach { subview in
            if String(describing: type(of: subview)) == "_UITableViewCellSwipeContainerView" {
                if let actionView = subview.subviews.first,
                   String(describing: type(of: actionView)) == "UISwipeActionPullView" {
                    actionView.layer.cornerRadius = 12
                    actionView.layer.masksToBounds = true
                    actionView.backgroundColor = .yaRed
                    (actionView.subviews.first as? UIButton)?.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
                }
            }
        }
    }
}
