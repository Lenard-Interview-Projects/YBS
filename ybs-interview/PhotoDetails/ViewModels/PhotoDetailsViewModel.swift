//
//  PhotoDetailsViewModel.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import YBSServices
import Combine

class PhotoDetailsViewModel: ObservableObject {
    @Published var photo = PhotoModel()
    @Published var isLoading = false
    @Published var isInitialized = false
    @Published var isEmpty = false
    @Published var errorFound = false

    private var photoId = ""
    private var photoServices: PhotoServicesProtocol?
    private var cancellables: Set<AnyCancellable> = []

    var getPhotoId: String {
        return photoId
    }

    init(photoId: String, photoServices: PhotoServicesProtocol) {
        self.photoServices = photoServices
        self.photoId = photoId
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
        guard let photoServices = photoServices else { return }

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
