////
// watchcord Watch App
// Created by circular with <3 on 2/8/2023
// please excuse my spaghetti code
//

import SwiftUI

struct MessageItem: View {
    var message: Message
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string:"https://cdn.discordapp.com/avatars/\(message.author.id)/\(message.author.avatar).png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20, maxHeight: 20)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(4)
            Text("\(message.author.global_name):\n\(message.content)")
                .font(.system(size:12))
        }
        .listRowBackground(Color.clear)
        .scaleEffect(x: 1, y: -1, anchor: .center)
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem(message: Message(
            id: "1136144263479054526",
            type: 0,
            content: "hi guys",
            channel_id: "775347652224352258",
            author: User(
                id: "305243321784336384",
                username: "circular",
                global_name: "the circlest of them all",
                avatar: "fc0914ced252a9754e6ffd3c64823b9b",
                discriminator: "0000"
            )
        ))
        .scaleEffect(x: 1, y: -1, anchor: .center) // revert the scale effect only for previews, the scale is reverted again in the actual file
    }
}
