//
//  SearchView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import SwiftUI
import YBSServices

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    @State private var selectedTagMode = false

    private let userServices: UserServicesProtocol
    private let photoServices: PhotoServicesProtocol
    private var columnGrid = [GridItem(.flexible(),
                                       spacing: 8,
                                       alignment: .top),
                              GridItem(.flexible(),
                                       spacing: 8,
                                       alignment: .top)]

    init(searchServices: SearchServicesProtocol,
         userServices: UserServicesProtocol,
         photoServices: PhotoServicesProtocol) {

        self._viewModel = StateObject(wrappedValue: SearchViewModel(searchServices: searchServices))
        self.userServices = userServices
        self.photoServices = photoServices
    }

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $viewModel.searchQuery)
                        .padding(.trailing, 16)

                    if viewModel.doesContainTags {
                        HStack {
                            RadioButton(selectedOption: $viewModel.selectedTagMode, option: FlickrTagMode.Some)
                            RadioButton(selectedOption: $viewModel.selectedTagMode, option: FlickrTagMode.All)
                        }
                    }
                }

                OrderByMenuView(orderBy: viewModel.selectedOrderBy,
                                relevanceAction: { },
                                interestingAction: { },
                                datePostedAscAction: { },
                                datePostedDescAction: { })
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)

            if viewModel.errorFound {
                VStack {
                    Image("missing_image")
                        .resizable()
                        .scaledToFit()

                    Button(action: { viewModel.loadMore() }, label: {
                        Text("There was an error click **here** to try again")
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(Color.white)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else if viewModel.isEmpty {
                VStack {
                    Image("missing_image")
                        .resizable()
                        .scaledToFit()

                    Text("No images have been found, try again")
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(viewModel.isInitialized ? .vertical : []) {
                    LazyVGrid(columns: columnGrid, spacing: 8) {
                        if !viewModel.isInitialized {
                            ForEach(0..<6, id:\.self) { _ in
                                SearchItemView(photoModel: SearchPhotoModel())
                                    .redacted(reason: .placeholder)
                            }
                        }
                        else {
                            ForEach(viewModel.images, id:\.id) { item in
                                NavigationLink(destination: { PhotoDetailsView(photoId: item.id,
                                                                               photoServices: photoServices,
                                                                               userServices: userServices) })
                                {
                                    SearchItemView(photoModel: item)
                                }
                            }
                        }

                        /** WhatNext
                         Rather than adding a progress view I would've use a framework called introspect to be able to get more information from the scrollview
                         and I would then detect when the users are near the bottom, that's when we load more content.

                         By doing so we can move the progress view outside the LazyVGrid and center it in the view.
                         */
                        if viewModel.isInitialized && viewModel.canLoadMore && !viewModel.isLoading {
                            ProgressView()
                                .onAppear {
                                    viewModel.loadMore()
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 16)
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.bottom, viewModel.images.isEmpty ? 0 : 32)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            if !viewModel.isInitialized {
                viewModel.fetchRecentResults()
            }

            viewModel.searchQueryListener()
        }
        .onDisappear {
            viewModel.cancelAllPublishers()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchServices: SearchServices(),
                   userServices: UserServices(),
                   photoServices: PhotoServices())
    }
}
