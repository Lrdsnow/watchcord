////
// watchcord Watch App
// Created by circular with <3 on 8/8/2023
// please excuse my spaghetti code
//

import SwiftUI

struct InitView: View {
    var body: some View {
        let WCDelegate = WCDelegate()
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
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
    }
}
