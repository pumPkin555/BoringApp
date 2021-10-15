//
//  BoringAppApp.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 13.10.2021.
//

import SwiftUI

@main
struct BoringAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
