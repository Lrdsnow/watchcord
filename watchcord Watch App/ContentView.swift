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
        if #available(watchOS 9.0, *) {
            NavigationStack {
                List {
                    // for each in guildfetcher get guilds
                    ForEach (guilds) {
                        guild in
                        NavigationLink {
                            //GuildDetails(guild: guild)
                            TabView {
                                GuildInfo(guild: guild)
                                GuildView(guild: guild)
                            }
                            .tabViewStyle(PageTabViewStyle())
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
        } else {
            List(guilds, id: \.id) { guild in
                NavigationLink(destination: GuildDetails(guild: guild)) {
                    GuildItem(guild: guild)
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Servers")
            .onAppear {
                if let tokenData = kread(service: "watchcord", account: "token"),
                   tokenData != Data() {
                    print("Token available")
                    guildFetcher.getGuilds() { guilds in
                        self.guilds = guilds
                    }
                } else {
                    print("No token")
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
