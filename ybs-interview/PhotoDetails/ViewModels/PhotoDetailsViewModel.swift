//
//  PhotoDetailsViewModel.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import Combine
import YBSServices
import YBSInjection

class PhotoDetailsViewModel: ObservableObject {
    @Published var photo = PhotoModel()
    @Published var isLoading = false
    @Published var isInitialized = false
    @Published var isEmpty = false
    @Published var errorFound = false

    private var photoId = ""
    private var cancellables: Set<AnyCancellable> = []

    @Injected private var photoServices: PhotoServicesProtocol

    var getPhotoId: String {
        return photoId
    }

    init(photoId: String) {
        self.photoId = photoId
    }

    convenience init(photoId: String, photoServices: PhotoServicesProtocol) {
        self.init(photoId: photoId)
        self.photoServices = photoServices
    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    public func fetchPhotoDetails() {
        if isLoading { return }
        if photoId.isEmpty { return }
        
        isLoading = true

        fetchResultFromService()
    }

    private func fetchResultFromService() {
        photoServices
            .fetchPhotoInfo(photoId: photoId)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    guard let self = self else { return }
                    self.errorFound = false

                    break
                case .failure(let error):
                    // Log the error into something like Firebase/Sentry
                    guard let self = self else { return }
                    self.errorFound = true
                    self.isLoading = false
                    self.isInitialized = true

                    print(error)
                    break
                }
            }, receiveValue: { [weak self] (data: PhotoResponseModel) in
                guard let self = self else { return }

                self.photo = data.photo
                self.isLoading = false
                self.isInitialized = true
            })
            .store(in: &cancellables)
    }
}
