//
//  watchcordApp.swift
//  watchcord Watch App
//
//  Created by circular on 8/5/2023.
//

import SwiftUI
import WatchKit

@main
struct watchcord_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView().onAppear {
//                Gateway.establishConnection()
//            }
            InitView()
        }
    }
}

class InterfaceController: WKInterfaceController {
    override func willActivate() {
        super.willActivate()
        
        //Gateway.checkConnection()
    }
}

class LifecycleController: NSObject, WKExtensionDelegate {
    func applicationDidFinishLaunching() {
        //Gateway.establishConnection()
    }
}
