////
// watchcord Watch App
// Created by circular with <3 on 8/8/2023
// please excuse my spaghetti code
//

import SwiftUI
import WatchConnectivity

struct SettingsView: View {
    let session = WCSession.default
    var WCDelegate: WCDelegate
    
    var body: some View {
        List {
            Button("Reset Token") {
                ksave(Data(), service: "watchcord", account: "token")
            }
        }
        .onAppear {
//            let WCDelegate = WCDelegate()
            Gateway.closeConnection()
            if WCSession.isSupported() {
                session.delegate = WCDelegate
                session.activate()
            }
        }
        .onDisappear {
            session.delegate = nil
        }
    }
}

class WCDelegate: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if (activationState == .activated) {
            print("activated")
        }
        if (error != nil) {
            print(error!.localizedDescription)
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if (message.keys.contains("Token")) {
            let token = message["Token"] as! String
            ksave(token.data(using: .utf8)!, service: "watchcord", account: "token")
        }
        print("received token")
        WKInterfaceDevice().play(.success)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(WCDelegate: WCDelegate())
    }
}
