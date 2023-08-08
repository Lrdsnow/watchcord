//
//  GuildItem.swift
//  watchcord Watch App
//
//  Created by circular on 2/6/2023.
//

import SwiftUI

struct GuildItem: View {
    var guild: Guild
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string:guild.icon)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 40, maxHeight: 40)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(8)
                Text(guild.name)
            }
        }
    }
}

struct GuildItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GuildItem(guild: Guild(id: "1088206123972186143", name: "Cowabunga", icon: "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png", owner: false, permissions: "8", features: []))
        }
    }
}
