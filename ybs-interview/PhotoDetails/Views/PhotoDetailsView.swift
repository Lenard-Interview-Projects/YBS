//
//  PhotoDetailsView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import SwiftUI
import YBSServices

struct PhotoDetailsView: View {
    @Environment(\.presentationMode) private var presentationMode

    @StateObject private var viewModel: PhotoDetailsViewModel
    @State private var extraDetail = false

    init(photoId: String) {
        _viewModel = StateObject(wrappedValue: PhotoDetailsViewModel(photoId: photoId))
    }

    var body: some View {
        GeometryReader { proxy in
            VStack {
                if viewModel.isLoading {
                    Text("Loadign")
                        .foregroundColor(Color.red)
                } else {
                    AsyncImage(url: URL(string: viewModel.photo.getPhotoUrl())) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .padding(16)
                                .frame(maxWidth: proxy.size.width, maxHeight: .infinity, alignment: .center)
                                .background(.blue)

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: proxy.size.width, maxHeight: .infinity, alignment: .center)

                        case .failure(_):
                            VStack {
                                Image("missing_image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("Failed to get the details for the photo: \(viewModel.getPhotoId)")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.white)
                            }
                            .frame(maxWidth: proxy.size.width, maxHeight: .infinity, alignment: .center)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .overlay(alignment: .bottom) {
                        LazyVStack(alignment: .leading) {
                            NavigationLink(destination: { UserProfileView(userId: viewModel.photo.owner.nsid) }) {
                                UserCardDetails(realname: viewModel.photo.owner.realname,
                                                userName: viewModel.photo.owner.username,
                                                iconfarm: viewModel.photo.owner.iconfarm,
                                                iconserver: viewModel.photo.owner.iconserver,
                                                nsid: viewModel.photo.owner.nsid,
                                                avatarSize: 50)
                                .padding(.bottom, 8)
                            }

                            ScrollView {
                                LazyVStack(alignment: .leading) {
                                    Text(viewModel.photo.getTitle)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)

                                    Text(viewModel.photo.getTakenDate.toFriendlyDateLong())
                                        .font(.caption)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.white)

                                    HStack {
                                        CategoryItem(title: "\(viewModel.photo.getCommentsCount) comments", separator: true)
                                        CategoryItem(title: "\(viewModel.photo.views) views")
                                    }

                                    Text(viewModel.photo.getDescription)
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                                    /**
                                     With  more time I would've probably used a UICollectionView in order to get the right visual,
                                     the spacing and width of the elements might be dynamic but it is not being displayed correctly by LazyHGrid
                                     */
                                    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())]) {
                                        ForEach(viewModel.photo.tags.tag, id:\.id) { tag in
                                            Text("#\(tag.raw)")
                                                .font(.body)
                                                .fontWeight(.light)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .frame(maxWidth: proxy.size.width - 32, minHeight: 50, alignment: .topLeading)
                                    .padding(.top, 16)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200, alignment: .topLeading)
                        }
                        .frame(maxWidth: .infinity, maxHeight: extraDetail ? 250 : 75, alignment: .topLeading)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 52)
                        .padding(.top, 16)
                        .background(BlurBackgroundView(style: .dark))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color("background"))
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear {
                if !viewModel.isInitialized {
                    viewModel.fetchPhotoDetails()
                }
            }
            .gesture(DragGesture().onChanged({ value in
                withAnimation(.linear) {
                    if value.translation.height > -75 {
                        extraDetail = true
                    }
                    if value.translation.height > 75 {
                        extraDetail = false
                    }
                }
            }))
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
}

struct PhotoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailsView(photoId: "")
    }
}
