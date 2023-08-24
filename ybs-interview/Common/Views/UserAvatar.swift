//
//  UserAvatar.swift
//  ybs-interview
//
//  Created by Lenard Pop on 25/08/2023.
//

import SwiftUI

struct UserAvatar: View {
    var farm: Int
    var server: String
    var userId: String

    var size: CGFloat = 35

    var body: some View {
        AsyncImage(url: URL(string: "https://farm\(farm).staticflickr.com/\(server)/buddyicons/\(userId)_l.jpg")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .padding(16)
                    .frame(width: size, height: size, alignment: .center)
                    .background(Color.gray)
                    .cornerRadius(size)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size, alignment: .center)
                    .shadow(color: Color.primary.opacity(0.3), radius: 1)
                    .cornerRadius(size)

            case .failure(_):
                Image("missing_avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size, alignment: .center)
                    .cornerRadius(size)

            @unknown default:
                EmptyView()
            }
        }
    }
}

struct UserAvatar_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatar(farm: 66, server: "65535", userId: "149567335@N07")
    }
}
