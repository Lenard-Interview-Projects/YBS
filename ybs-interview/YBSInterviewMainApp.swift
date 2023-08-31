//
//  ybs_interviewApp.swift
//  ybs-interview
//
//  Created by Lenard Pop on 24/08/2023.
//

import SwiftUI
import YBSServices
import YBSInjection

@main
struct ybs_interviewApp: App {
    init() {
        registerDepenedencies()
    }

    private func registerDepenedencies() {
        DependecyInjection.register(dependency: PhotoServices() as PhotoServicesProtocol)
        DependecyInjection.register(dependency: UserServices() as UserServicesProtocol)
        DependecyInjection.register(dependency: SearchServices() as SearchServicesProtocol)
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchView()
            }
        }
    }
}
