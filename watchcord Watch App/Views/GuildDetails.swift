//
//  GuildDetails.swift
//  watchcord Watch App
//
//  Created by circular on 2/6/2023.
//

import SwiftUI

struct GuildDetails: View {
    var guild: Guild
    @State private var channels: [Channel] = []
    
    var body: some View {
        VStack {
//            NavigationView {
//                List {
//                    NavigationLink {
//                        GuildDetails(guild: Guild(id: "1088206123972186143", name: "Cowabunga", icon: "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png", owner: false, permissions: "8", features: []))
//                    } label: {
//                        ChannelItem(channel: Channel(id: "1088206126467784826", type: 0, name: "general", parent: ""))
//                    }
//                }
//                .navigationTitle("Channels")
//                .toolbar(.hidden)
//            }
//            NavigationView {
//                List {
//                    // for each in guildfetcher get guilds
//                    ForEach (channels) {
//                        guild in
//                        NavigationLink {
//                            GuildDetails(guild: guild)
//                        } label: {
//                            GuildItem(guild: guild)
//                        }
//                        .padding(.vertical, 10)
//                    }
//                }
//                .navigationTitle("Servers")
//                .onAppear {
//                    channelFetcher.getChannels(guild: self.guild) {
//                        channels in
//                        self.channels = channels
//                    }
//                }
//
//            }
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
            .navigationTitle("Channels")
            .onAppear {
                channelFetcher.getChannels(guild: self.guild) {
                    channels in
                    self.channels = channels
                }
            }
        }
    }
}

struct GuildDetails_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GuildDetails(guild: Guild(id: "775347651562569780", name: "Cowabunga", icon: "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png", owner: false, permissions: "8", features: []))
        }
    }
}
