//
//  CategoryItem.swift
//  ybs-interview
//
//  Created by Lenard Pop on 26/08/2023.
//

import SwiftUI

struct CategoryItem: View {
    var title: String
    var icon: String = ""
    var separator: Bool = false
    var color: Color = Color.white
    var enableAction: Bool = false
    var action: () -> Void = { }

    var body: some View {
        HStack {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 20, height: 20)
            }

            Text(title)
                .font(.body)
                .fontWeight(.light)
                .foregroundColor(color)

            if separator {
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 5, height: 5)
            }

            if enableAction {
                Spacer()

                Button(action: { action() }) {
                    HStack {
                        Text("Show all")
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(color)

                        Image(systemName: "arrow.forward")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(color)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStack(alignment: .leading) {
            CategoryItem(title: "Title", icon: "eye", color: Color.black)
            CategoryItem(title: "Title", icon: "eye", color: Color.black, enableAction: true)
            CategoryItem(title: "Title", color: Color.black, enableAction: true)
            CategoryItem(title: "Title", separator: true, color: Color.black, enableAction: true)
        }
        .padding(16)
    }
}
