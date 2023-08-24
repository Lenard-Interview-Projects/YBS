//
//  StatsItemContainer.swift
//  ybs-interview
//
//  Created by Lenard Pop on 27/08/2023.
//

import SwiftUI

struct StatsItemContainer: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Text(title)
                .font(.title3)
                .fontWeight(.regular)
                .foregroundColor(Color.white.opacity(0.6))
        }
        .frame(width: 175, height: 100, alignment: .center)
        .background(Color.black.opacity(0.5))
        .cornerRadius(25)
    }
}

struct StatsItemContainer_Previews: PreviewProvider {
    static var previews: some View {
        StatsItemContainer(title: "Downloads", value: "12K")
    }
}
