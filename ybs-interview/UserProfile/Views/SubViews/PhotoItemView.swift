//
//  PhotoItemView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 26/08/2023.
//

import SwiftUI
import YBSServices

struct PhotoItemView: View {
    var photoModel: SearchPhotoModel

    var body: some View {
        VStack {
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
                        .frame(height: 200)

                case .failure(_):
                    Image("missing_image")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(Color.red)

                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .cornerRadius(15)
    }
}

struct PhotoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 8),
                                GridItem(.adaptive(minimum: 150), spacing: 8)], spacing: 8) {
                ForEach(0..<10, id:\.self) { i in
                    PhotoItemView(photoModel: SearchPhotoModel())
                }
            }
        }
    }
}
