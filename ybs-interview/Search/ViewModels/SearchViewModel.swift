//
//  SearchViewModel.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import Combine
import YBSServices

class SearchViewModel: ObservableObject {
    @Published var images: [SearchPhotoModel] = []
    @Published var isLoading = false
    @Published var isInitialized = false
    @Published var isEmpty = false
    @Published var canLoadMore = true
    @Published var errorFound = false

    @Published var searchQuery: String = ""
    @Published var selectedOrderBy: SearchOrderBy = .Relevance
    @Published var selectedTagMode: FlickrTagMode = .Some  {
        didSet {
            // Lazy way of just triggering the publisher to grab new images when we change the tagMode
            let oldQuery = searchQuery
            searchQuery = oldQuery
        }
    }

    private var currentPage = 1
    private var searchPublisher: AnyPublisher<SearchResponseModel, Error>? = nil
    private var cancellables: Set<AnyCancellable> = []
    private let searchServices: SearchServicesProtocol?

    public var doesContainTags: Bool {
        return !searchQuery.toListOfTags().isEmpty
    }

    init(searchServices: SearchServicesProtocol) {
        self.searchServices = searchServices
    }

    deinit {
        cancelAllPublishers()
    }

    public func cancelAllPublishers() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    public func loadMore() {
        if isLoading { return }

        isLoading = true

        if searchQuery.isEmpty {
            setSearchRecentPublisher()
        } else {
            setSearchQueryPublisher()
        }
    }

    public func fetchRecentResults() {
        if isLoading { return }
        if !canLoadMore { return }

        isLoading = true

        setSearchRecentPublisher()
    }

    public func searchQueryListener() {
         $searchQuery
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .map { string in
               return string.isEmpty
            }
            .sink { [weak self] isEmpty in
                guard let self = self else { return }

                if isLoading { return }
                if isEmpty { return }

                self.isLoading = true
                self.currentPage = 1
                self.images.removeAll()

                self.setSearchQueryPublisher()
            }
            .store(in: &cancellables)
    }

    private func setSearchRecentPublisher() {
        guard let searchServices = searchServices else { return }

        searchPublisher = searchServices.fetchRecentResults(page: currentPage)
        fetchSearchResultsFromService()
    }

    private func setSearchQueryPublisher() {
        guard let searchServices = searchServices else { return }

        searchPublisher = searchServices.fetchSearchResults(search: searchQuery, tagMode: selectedTagMode, page: currentPage)
        fetchSearchResultsFromService()
    }

    private func fetchSearchResultsFromService() {
        guard let searchPublisher = searchPublisher else { return }

        searchPublisher
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    guard let self = self else { return }
                    
                    self.errorFound = false
                    break
                case .failure(let error):
                    guard let self = self else { return }

                    // Log the error into something like Firebase/Sentry
                    print(error)
                    self.isLoading = false
                    self.isInitialized = true
                    self.canLoadMore = false
                    self.errorFound = true
                    break
                }
            }, receiveValue: { [weak self] (data: SearchResponseModel) in
                guard let self = self else { return }

                self.images.append(contentsOf: data.photos.photo)
                self.isEmpty = data.photos.photo.isEmpty
                self.canLoadMore = !data.photos.photo.isEmpty
                self.isLoading = false
                self.isInitialized = true

                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
