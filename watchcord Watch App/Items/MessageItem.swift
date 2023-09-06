////
// watchcord Watch App
// Created by circular with <3 on 2/8/2023
// please excuse my spaghetti code
//

import SwiftUI

struct MessageItem: View {
    var message: Message
    @State private var time: String = ""
    
    // can't preview this file due to localconsole causing unexpected issues
    // this isnt a localconsole issue, this is a bug
    // solution (l8r): clone this project and remove localconsole
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string:"https://cdn.discordapp.com/avatars/\(message.author.id)/\(message.author.avatar).png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: 26, maxHeight: 26)
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 26, maxHeight: 26)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(4)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("\(message.author.global_name)")
                        .font(.system(size:12))
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                    Text("\(message.timestamp.formatted(date: .omitted, time: .shortened))")
                        .font(.system(size:12))
                        .fontWeight(.thin)
                }
                .frame(height: 12)
                Text("\(message.content)")
                    .font(.system(size:12))
            }
        }
        .listRowBackground(Color.black.brightness(0.1).clipShape(RoundedRectangle(cornerRadius: 8)))
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
            timestamp: DefaultMessage.dateFormatter.date(from: "2023-08-03T03:35:30.187000+00:00")!,
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
