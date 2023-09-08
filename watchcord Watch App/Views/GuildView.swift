//
//  GuildDetails.swift
//  watchcord Watch App
//
//  Created by circular on 2/6/2023.
//

import SwiftUI

struct GuildView: View {
    var guild: Guild
    @State private var channels: [Channel] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(channels) { channel in
                    if (channel.type == 4) {
                        NavigationLink {
                            ChannelView(guild: guild, channels: channels, parent: channel.id)
                        } label: {
                            ChannelItem(channel: channel)
                        }
                    }
                    if (channel.parent == "" && channel.type != 4) {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Channels")
        .onAppear {
            channelFetcher.getChannels(guild: self.guild) {
                channels in
                self.channels = channels
            }
        }
    }
}

struct GuildDetails_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GuildView(guild: Guild(id: "775347651562569780", name: "Cowabunga", icon: "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png", owner: false, permissions: "8", features: []))
        }
    }
}
