////
// watchcord Watch App
// Created by circular with <3 on 8/8/2023
// please excuse my spaghetti code
//

import SwiftUI

struct InitView: View {
    var body: some View {
        let WCDelegate = WCDelegate()
        if #available(watchOS 9.0, *) {
            NavigationStack {
                List {
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("Servers")
                    }
                    NavigationLink {
                        Text("not implemented :P")
                    } label: {
                        Text("Friends").foregroundColor(.red)
                    }
                    NavigationLink {
                        SettingsView(WCDelegate: WCDelegate)
                    } label: {
                        Text("Settings")
                    }
                }
            }
            .navigationTitle("watchcord")
        } else {
            List {
                NavigationLink(destination: ContentView()) {
                    Text("Servers")
                }
                NavigationLink(destination: Text("not implemented :P").foregroundColor(.red)) {
                    Text("Friends")
                }
                NavigationLink(destination: SettingsView(WCDelegate: WCDelegate)) {
                    Text("Settings")
                }
            }
            .navigationBarTitle("watchcord")
        }
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
    }
}
