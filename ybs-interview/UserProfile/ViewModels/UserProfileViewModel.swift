//
//  UserProfileViewModel.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import YBSServices
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var user = UserModel()
    @Published var gallery: [SearchPhotoModel] = []
    @Published var isLoading = false
    @Published var isInitialized = false
    @Published var isEmpty = false
    @Published var canLoadMore = true
    @Published var errorFound = false

    private var currentPage = 1
    private var userId = ""
    private var userServices: UserServicesProtocol?
    private var cancellables: Set<AnyCancellable> = []

    init(userId: String, userServices: UserServicesProtocol) {
        self.userId = userId
        self.userServices = userServices
    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    public func loadMore() {
        if isLoading { return }

        isLoading = true

        fetchGalleryResultsFromService()
    }

    public func fetchUserDetails() {
        if isLoading { return }
        if userId.isEmpty { return }

        isLoading = true

        fetchUserInfoResultsFromService()
    }

    private func fetchUserInfoResultsFromService() {
        guard let userServices = userServices else { return }

        userServices
            .getUserInfo(userId: userId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    guard let self = self else { return }
                    self.errorFound = false

                    break
                case .failure(let error):
                    // Log the error into something like Firebase/Sentry
                    guard let self = self else { return }
                    self.isLoading = false
                    self.isInitialized = true
                    self.errorFound = true
                    self.canLoadMore = false
                    
                    print(error)
                    break
                }
            }, receiveValue: { [weak self] (data: UserResponseModel) in
                guard let self = self else { return }

                self.user = data.person
                self.fetchGalleryResultsFromService()
            })
            .store(in: &cancellables)
    }

    private func fetchGalleryResultsFromService() {
        guard let userServices = userServices else { return }

        userServices
            .getUserPhotos(userId: userId, perPage: 20, page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    guard let self = self else { return }
                    self.errorFound = false

                    break
                case .failure(let error):
                    // Log the error into something like Firebase/Sentry
                    guard let self = self else { return }
                    self.isLoading = false
                    self.isInitialized = true
                    self.errorFound = true
                    self.canLoadMore = false

                    print(error)
                    break
                }
            }, receiveValue: { [weak self] (data: SearchResponseModel) in
                guard let self = self else { return }

                self.gallery.append(contentsOf: data.photos.photo)
                self.canLoadMore = !data.photos.photo.isEmpty
                self.isLoading = false
                self.isInitialized = true
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
