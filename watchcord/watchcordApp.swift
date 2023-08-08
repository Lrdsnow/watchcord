//
//  watchcordApp.swift
//  watchcord
//
//  Created by circular on 8/5/2023.
//

import SwiftUI

@main
struct watchcordApp: App {
    var body: some Scene {
        let WCDelegate = WCDelegate()
        WindowGroup {
            ContentView(WCDelegate: WCDelegate)
        }
    }
}
