//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 05.11.2023.
//

import UIKit

protocol ProfileViewModelProtocol: AnyObject {
    var onChange: (() -> Void)? { get set }
    var onLoaded: (() -> Void)? { get set }
    var onError: (() -> Void)? { get set }
    var avatarURL: URL? { get }
    var name: String? { get }
    var description: String? { get }
    var website: String? { get }
    var nfts: [String]? { get }
    var likes: [String]? { get }
    var id: String? { get }
    var error: Error? { get }
    
    func getProfileData()
    func putProfileData(name: String, avatar: String, description: String, website: String, likes: [String])
    func fillSelfFromResponse(response: Profile)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    var onChange: (() -> Void)?
    var onLoaded: (() -> Void)?
    var onError: (() -> Void)?
    var coordinator: ProfileCoordinator
    
    private let service = ServicesAssembly.shared.nftService
    
    private(set) var avatarURL: URL? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var name: String? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var description: String? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var website: String? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var nfts: [String]? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var likes: [String]? {
        didSet {
            onChange?()
        }
    }
    
    private(set) var id: String?
    private(set) var error: Error?
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func getProfileData() {
        UIBlockingProgressHUD.show()
        service.loadProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.fillSelfFromResponse(response: profile)
                self?.nfts = profile.nfts
                self?.likes = profile.likes
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                self?.error = error
                self?.onError?()
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func putProfileData(name: String, avatar: String, description: String, website: String, likes: [String]) {
        UIBlockingProgressHUD.show()
        let profileDTO = ProfileDto(
            name: name,
            avatar: avatar,
            description: description,
            website: website,
            likes: likes)
        
        service.updateProfile(nftProfileDto: profileDTO) { [weak self] result in
            switch result {
            case .success(let profile):
                self?.fillSelfFromResponse(response: profile)
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                self?.error = error
                self?.onError?()
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func fillSelfFromResponse(response: Profile) {
        self.avatarURL = response.avatar
        self.name = response.name
        self.description = response.description
        self.website = response.website.description
        self.id = response.id
        self.nfts = response.nfts
    }
}
