//
//  GuildItem.swift
//  watchcord Watch App
//
//  Created by circular on 2/6/2023.
//
import SwiftUI

struct GuildItem: View {
    var guild: Guild
    
    @ViewBuilder
    func guildImage() -> some View {
        if #available(watchOS 8.0, *) {
            AsyncImage(url: URL(string: guild.icon)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 40, height: 40)
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 40, maxHeight: 40)
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 40, height: 40)
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)
        } else {
            if let url = URL(string: guild.icon),
               let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 40, maxHeight: 40)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 40, height: 40)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                guildImage()
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
