//
//  SearchBarView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 27/08/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.white)

                TextField("Search", text: $searchText)
                    .foregroundColor(Color.white)

            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color("backgroundSecondary"))
            .cornerRadius(4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Cat pictures"))
    }
}
