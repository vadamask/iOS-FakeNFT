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
        self?.myNFTTable.reloadData()
    }
    
    viewModel.onError = { [weak self] error in
        let alert = UIAlertController(
            title: "Нет интернета",
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
        self?.saveSortOrder(order: .price)
    }
    let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
        self?.viewModel.sort = .rating
        self?.saveSortOrder(order: .rating)
    }
    let sortByNameAction = UIAlertAction(title: "По названию", style: .default) { [weak self] _ in
        self?.viewModel.sort = .name
        self?.saveSortOrder(order: .name)
    }
    let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)
    
    alert.addAction(sortByPriceAction)
    alert.addAction(sortByRatingAction)
    alert.addAction(sortByNameAction)
    alert.addAction(closeAction)
    
    present(alert, animated: true)
}

private func saveSortOrder(order: MyNFTViewModel.Sort) {
    let data = try? PropertyListEncoder().encode(order)
    UserDefaults.standard.set(data, forKey: "sortOrder")
}

private func setupView() {
    if ((viewModel.myNFTs?.isEmpty) != nil) {
        view.backgroundColor = .screenBackground
        setupNavBar(emptyNFTs: true)
        setupEmptyLabel()
    } else {
        setupNavBar(emptyNFTs: false)
    }
}

func setupNavBar(emptyNFTs: Bool) {
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = backButton
    view.backgroundColor = .screenBackground
    backButton.accessibilityIdentifier = "backButton"
    if !emptyNFTs {
        navigationItem.rightBarButtonItem = sortButton
        navigationItem.title = "Мои NFT"
    }
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

extension MyNFTViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myNFTs = viewModel.myNFTs else { return 0 }
        return myNFTs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyNFTCell = tableView.dequeueReusableCell()
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        guard let myNFTs = viewModel.myNFTs,
              !myNFTs.isEmpty else { return MyNFTCell() }
        
        let myNFT = myNFTs[indexPath.row]
        
        let model = MyNFTCell.CellModel(
            image: myNFT.images.first ?? "",
            name: myNFT.name,
            rating: myNFT.rating,
            author: viewModel.authors[myNFT.author] ?? "",
            price: myNFT.price,
            isFavorite: viewModel.likedIDs?.contains(myNFT.id) ?? false,
            id: myNFT.id
        )
        
        cell.tapAction = { [weak self] in
            let tappedNFT = self?.viewModel.myNFTs?.filter({ $0.id == myNFT.id }).first
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myNFTliked"), object: tappedNFT)
            if let tappedNFTid = tappedNFT?.id { self?.viewModel.toggleLikeFromMyNFT(id: tappedNFTid) }
        }
        cell.configureCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
