//
//  MyNFTViewModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 22.11.2023.
//

import UIKit

protocol MyNFTViewModelProtocol: AnyObject {
    var onChange: (() -> Void)? { get set }
    var onError: ((_ error: Error) -> Void)? { get set }
    var myNFTs: [Nft]? { get }
    var likedIDs: [String]? { get }
    var authors: [String: String] { get }
    var sort: MyNFTViewModel.Sort? { get set }
    
    func getMyNFTs(nftIDs: [String])
    func toggleLikeFromMyNFT(id: String)
}

final class MyNFTViewModel: MyNFTViewModelProtocol {
    var onChange: (() -> Void)?
    var onError: ((_ error: Error) -> Void)?
    
    private var service = ServicesAssembly.shared.nftService
        
    private(set) var myNFTs: [Nft]? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var likedIDs: [String]? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var authors: [String: String] = [:] {
        didSet {
            onChange?()
        }
    }
    
    var sort: Sort? {
        didSet {
            guard let sort else { return }
            myNFTs = applySort(by: sort)
        }
    }
    
    init(nftIDs: [String], likedIDs: [String]) {
        self.myNFTs = []
        self.likedIDs = likedIDs
        getMyNFTs(nftIDs: nftIDs)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(unlikeMyNFTfromFavorites),
            name: NSNotification.Name(rawValue: "favoriteUnliked"),
            object: nil
        )
    }
    
    func getMyNFTs(nftIDs: [String]) {
        UIBlockingProgressHUD.show()
        var loadedNFTs: [Nft] = []
        nftIDs.forEach { id in
            service.loadNft(id: id) { [weak self] result in
                switch result {
                case .success(let nft):
                    loadedNFTs.append(nft)
                    if loadedNFTs.count == nftIDs.count {
                        self?.getAuthors(nfts: loadedNFTs)
                        self?.myNFTs? = loadedNFTs
                        UIBlockingProgressHUD.dismiss()
                    }
                case .failure(let error):
                    self?.onError?(error)
                    UIBlockingProgressHUD.dismiss()
                }
            }
        }
    }
    
    func toggleLikeFromMyNFT(id: String) {
        guard var likedIDs = self.likedIDs else { return }
        if likedIDs.contains(id) {
        likedIDs = likedIDs.filter { $0 != id }
        } else {
            likedIDs.append(id)
        }
        let profileLikesDto = ProfileLikesDto(likes: likedIDs)
        service.updateLikes(likesProfileDto: profileLikesDto) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.likedIDs = profile.likes
            case .failure(let error):
                self?.onError?(error)
                return
            }
        }
    }

    private func getAuthors(nfts: [Nft]) {
        var authorsSet: [String] = []
        nfts.forEach { nft in
            authorsSet.append(nft.author)
        }
        authorsSet.forEach { author in
            service.loadUser(by: author) { [weak self] result in
                switch result {
                case .success(let author):
                    self?.authors.updateValue(author.name, forKey: author.id)
                case .failure(let error):
                    self?.onError?(error)
                    return
                }
            }
        }
    }
    
    @objc private func unlikeMyNFTfromFavorites(notification: Notification) {
        let nftID = notification.object as? String
        self.likedIDs = likedIDs?.filter { $0 != nftID }
    }
    
    private func applySort(by value: Sort) -> [Nft] {
        guard let myNFTs = myNFTs else { return [] }
        switch value {
        case .price:
            return myNFTs.sorted(by: { $0.price < $1.price })
        case .rating:
            return myNFTs.sorted(by: { $0.rating > $1.rating })
        case .name:
            return myNFTs.sorted(by: { $0.name < $1.name })
        }
    }
}

extension MyNFTViewModel {
    enum Sort: Codable {
        case price
        case rating
        case name
    }
}
