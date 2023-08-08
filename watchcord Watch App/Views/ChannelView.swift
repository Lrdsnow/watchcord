//
// watchcord Watch App
// Created by circular with <3 on 26/7/2023
// please excuse my spaghetti code
//

import SwiftUI

struct ChannelView: View {
    var guild: Guild
    var channels: [Channel]
    var parent: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(channels) { channel in
                    if (channel.parent == parent) {
                        NavigationLink {
                            Messages(channel: channel)
                        } label: {
                            ChannelItem(channel: channel)
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .navigationTitle("Channels")
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChannelView(
                guild: Guild(id: "775347651562569780", name: "Cowabunga", icon: "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png", owner: false, permissions: "8", features: []),
                channels: [Channel(id: "0", type: 4, name: "info", parent: "5")],
                parent: "5"
            )
        }
    }
}
