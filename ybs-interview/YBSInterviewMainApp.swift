//
//  ybs_interviewApp.swift
//  ybs-interview
//
//  Created by Lenard Pop on 24/08/2023.
//

import SwiftUI
import YBSServices

@main
struct ybs_interviewApp: App {
    let searchServices = SearchServices()
    let userServices = UserServices()
    let photoServices = PhotoServices()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchView(searchServices: searchServices,
                           userServices: userServices,
                           photoServices: photoServices)
            }
        }
    }
}
