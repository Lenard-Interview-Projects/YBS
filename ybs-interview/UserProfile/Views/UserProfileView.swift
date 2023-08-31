//
//  UserProfileView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import SwiftUI
import YBSServices

struct UserProfileView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject private var viewModel: UserProfileViewModel
    @State private var showSheet = true

    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: UserProfileViewModel(userId: userId))
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.blue)
            }
            else {
                GeometryReader { proxy in
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 16) {
                            ForEach(viewModel.gallery.prefix(20), id:\.id) { item in
                                AsyncImage(url: URL(string: item.getPhotoUrl())) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .padding(16)
                                            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                                            .background(.blue)

                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                                            .clipped()

                                    case .failure(_):
                                        // Report to Analytics/Crashalytics
                                        EmptyView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showSheet, onDismiss: { showSheet = viewModel.isLoading ? false : true }) {
            /** Why was the ScrollView needed
             - In order to make sure the bottomSheet content is top aligned I used a ScrollView as that resizes based on the parent size
                by doing so I can ensure the alignment is corrent as the alignment for the frame doesn't work when the sheet is below `.fraction(0.45)`
             */
            ScrollView([], showsIndicators: false) {
                VStack(alignment: .leading) {
                    UserCardDetails(user: viewModel.user)
                        .padding(.horizontal, 16)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 0), GridItem(.adaptive(minimum: 150), spacing: 0)]) {
                        StatsItemContainer(title: "Downloads", value: "12K")
                        StatsItemContainer(title: "Views", value: "50K")
                    }
                    .padding(.top, 32)

                    VStack(alignment: .leading, spacing: 16) {
                        CategoryItem(title: "First release: \(viewModel.user.photos.getFirstPhotoDate.toFriendlyDateLong())", icon: "calendar")

                        if !viewModel.user.getLocation.isEmpty {
                            CategoryItem(title: "\(viewModel.user.getLocation)", icon: "location")
                        }

                        if viewModel.user.photos.getCount != 0 {
                            CategoryItem(title: "\(viewModel.user.photos.getCount)", icon: "photo.on.rectangle", enableAction: true, action: { })
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 16)

                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 8),
                                            GridItem(.adaptive(minimum: 150), spacing: 8),
                                            GridItem(.adaptive(minimum: 150), spacing: 8)], spacing: 8) {
                            if !viewModel.isInitialized {
                                ForEach(0..<6, id:\.self) { _ in
                                    SearchItemView(photoModel: SearchPhotoModel())
                                        .redacted(reason: .placeholder)
                                }
                            }
                            else {
                                ForEach(viewModel.gallery, id:\.id) { photo in
                                    PhotoItemView(photoModel: photo)
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
                        .padding(4)
                    }

                    Spacer()
                }
            }
            .padding(16)
            .padding(.top, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(BlurBackgroundView(style: .dark))
            .presentationDetents([.fraction(0.1), .fraction(0.6), .fraction(0.9)])
            .presentationBackground(Color.clear) // I set the background to be clear as I they don't provide a black thin material color
            .presentationCornerRadius(50)
            .presentationBackgroundInteraction(.enabled)
            .ignoresSafeArea()
        }
        .onAppear {
            if !viewModel.isInitialized {
                viewModel.fetchUserDetails()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white)
                        .frame(width: 16, height: 16, alignment: .center)
                        .padding(12)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(35)
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userId: "12037949754@N01")
    }
}
