//
//  ContentView.swift
//  watchcord
//
//  Created by circular on 8/5/2023.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @State private var token: String = ""
    let WCDelegate: WCDelegate
    
    var body: some View {
        VStack {
            Image(systemName: "message.fill")
                .font(.largeTitle)
            Text("watchcord")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("an app to use discord from your watch")
                .fontWeight(.semibold)
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .padding(.leading, 6)
                Text("**VERY** early development preview, please report bugs to me *(circular on discord)*")
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .padding([.top, .bottom, .trailing], 6)
            }
            .background(Color.red.opacity(0.5))
            .cornerRadius(5)
            Text("use the field below to save your token so you can use the watch app")
                .multilineTextAlignment(.center)
            SecureField("Token...", text: $token)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("Save") {
                    if token != "" {
                        ksave(token.data(using: .utf8)!, service: "watchcord", account: "token")
                    }
                }
                .buttonStyle(.borderedProminent)
                Button("Send to Watch") {
                    if (WCSession.default.isReachable) {
                        let message = ["Token": $token.wrappedValue]
                        WCSession.default.sendMessage(message, replyHandler: nil)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear {
            //let WCDelegate = WCDelegate()
            let token = kread(service: "watchcord", account: "token")
            if token != nil {
                self.token = String(decoding: token!, as: UTF8.self)
            }
            if (WCSession.isSupported()) {
                let session = WCSession.default
                session.delegate = WCDelegate
                session.activate()
            }
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

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(WCDelegate: WCDelegate())
    }
}
