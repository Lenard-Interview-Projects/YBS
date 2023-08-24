//
//  FilterTypeMenuView.swift
//  ybs-interview
//
//  Created by Lenard Pop on 22/08/2023.
//

import SwiftUI
import YBSServices

struct OrderByMenuView: View {
    var orderBy: SearchOrderBy = .Relevance

    var relevanceAction: () -> Void = {}
    var interestingAction: () -> Void = {}
    var datePostedAscAction: () -> Void = {}
    var datePostedDescAction: () -> Void = {}

    var body: some View {
        Menu(content: {
            Button { relevanceAction() } label: {
                HStack {
                    Text("By Relevance")

                    if orderBy.equal(to: .Relevance) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Button { interestingAction() } label: {
                HStack {
                    Text("By Interesting")

                    if orderBy.equal(to: .Interesting) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Button { datePostedAscAction() } label: {
                HStack {
                    Text("By Date Taken ↓")

                    if orderBy.equal(to: .DateTakenAsc) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            Button { datePostedDescAction() } label: {
                HStack {
                    Text("By Date Taken ↑")

                    if orderBy.equal(to: .DateTakenDesc) {
                        Image(systemName: "staroflife.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }, label: {
            Image(systemName: "arrow.up.arrow.down")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color.white)
        })
    }
}

struct FilterTypeMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OrderByMenuView()
    }
}
