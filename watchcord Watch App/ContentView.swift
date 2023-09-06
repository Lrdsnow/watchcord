//
//  ContentView.swift
//  watchcord Watch App
//
//  Created by circular on 8/5/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var guilds: [Guild] = []
    
    var body: some View {
        NavigationStack {
            List {
                // for each in guildfetcher get guilds
                ForEach (guilds) {
                    guild in
                    NavigationLink {
                        GuildDetails(guild: guild)
                    } label: {
                        GuildItem(guild: guild)
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Servers")
            .onAppear {
                if (kread(service: "watchcord", account: "token") == nil || kread(service: "watchcord", account: "token") == Data()) {
                    print("no token")
                    return
                } else {
                    //Gateway.checkConnection()
                    guildFetcher.getGuilds() {
                        guilds in
                        self.guilds = guilds
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
