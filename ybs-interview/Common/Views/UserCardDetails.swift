//
//  UserCardDetails.swift
//  ybs-interview
//
//  Created by Lenard Pop on 26/08/2023.
//

import SwiftUI
import YBSServices

struct UserCardDetails: View {
    var realname: String
    var userName: String

    var iconfarm: Int
    var iconserver: String
    var nsid: String

    var avatarSize: CGFloat = 50

    init(realname: String, userName: String, iconfarm: Int, iconserver: String, nsid: String, avatarSize: CGFloat) {
        self.realname = realname
        self.userName = userName
        self.iconfarm = iconfarm
        self.iconserver = iconserver
        self.nsid = nsid
        self.avatarSize = avatarSize
    }

    init(user: UserModel) {
        self.realname = user.getRealname
        self.userName = user.getUsername
        self.iconfarm = user.iconfarm
        self.iconserver = user.iconserver
        self.nsid = user.nsid
    }

    var body: some View {
        HStack {
            UserAvatar(farm: iconfarm,
                       server: iconserver,
                       userId: nsid, size: avatarSize)
            VStack(alignment: .leading) {
                Group {
                    if !realname.isEmpty {
                        Text(realname)
                            .font(.title)
                            .lineLimit(1)
                    }

                    if !userName.isEmpty {
                        Text("@\(userName)")
                            .font(.body)
                            .lineLimit(1)
                    }
                }
                .fontWeight(.light)
                .foregroundColor(Color.white)
            }
        }
    }
}

struct UserCardDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserCardDetails(realname: "", userName: "", iconfarm: 0, iconserver: "", nsid: "", avatarSize: 50)
    }
}
