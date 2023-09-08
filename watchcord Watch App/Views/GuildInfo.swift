////
// watchcord Watch App
// Created by circular with <3 on 7/9/2023
// please excuse my spaghetti code
//

import SwiftUI

struct GuildInfo: View {
    var guild: Guild
    @State private var extguild: ExtGuild = ExtGuild(id: "", name: "", ownerid: "", memberCount: 0, onlineCount: 0)
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string:guild.icon)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: 100, maxHeight: 100)
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100, maxHeight: 100)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(8)
            Text(guild.name)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .truncationMode(.tail)
                .multilineTextAlignment(.center)
                .frame(maxHeight: 48)
            HStack {
                Image(systemName: "person.fill")
                Text(extguild.memberCount.description)
            }
        }
        .onAppear {
            extendGuild.extendGuild(guild: guild) { extguild in
                self.extguild = extguild
            }
        }
    }
}

struct GuildInfo_Previews: PreviewProvider {
    static var previews: some View {
        GuildInfo(guild: Guild(id: "775347651562569780", name: "Cowabunga", icon: "https://cdn.discordapp.com/icons/1088206123972186143/a_709bd6cb0a63e1290fc7127ed648e627.png", owner: false, permissions: "8", features: []))
    }
}
