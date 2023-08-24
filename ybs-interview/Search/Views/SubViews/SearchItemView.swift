//
//  SearchItemView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import SwiftUI
import YBSServices

struct SearchItemView: View {
    var photoModel: SearchPhotoModel

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: photoModel.getPhotoUrl())) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .padding(16)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .background(.gray)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 250)

                    case .failure(_):
                        Image("missing_image")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .background(Color.white)

                    @unknown default:
                        EmptyView()
                    }
                }

                HStack(alignment: .center) {
                    UserAvatar(farm: photoModel.farm,
                               server: photoModel.server,
                               userId: photoModel.owner)
                    
                    Text(photoModel.owner)
                        .font(.body)
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
                .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.9)]),
                                           startPoint: .top,
                                           endPoint: .bottom))
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
            }
        }
        .frame(maxWidth: .infinity, minHeight: 250)
        .cornerRadius(15)
        .overlay(alignment: .topLeading) {
            Button { } label: {
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
            }
            .frame(width: 35, height: 35, alignment: .center)
            .background(.black.opacity(0.75))
            .cornerRadius(25)
            .offset(x: 5, y: 5)
        }
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(photoModel: SearchPhotoModel())
    }
}
