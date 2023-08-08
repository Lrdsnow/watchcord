//
//  Messages.swift
//  watchcord Watch App
//
//  Created by circular on 2/6/2023.
//

import SwiftUI
import Combine

struct Messages: View {
    var channel: Channel
    @State private var messages: [Message] = []
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        VStack {
            List {
//                HStack {
//                    AsyncImage(url: URL(string:"https://cdn.discordapp.com/avatars/305243321784336384/fc0914ced252a9754e6ffd3c64823b9b.png")) { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView()
//                        case .success(let image):
//                            image.resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(maxWidth: 20, maxHeight: 20)
//                        case .failure:
//                            Image(systemName: "photo")
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
//                    .cornerRadius(4)
//                    Text("circular:\nITS DRIVING ME INSANE")
//                        .font(.system(size:12))
//                }
//                .listRowBackground(Color.clear)
//                .scaleEffect(x: 1, y: -1, anchor: .center)
//                MessageItem(message: Message(
//                    id: "1136144263479054526",
//                    type: 0,
//                    content: "hi guys",
//                    channel_id: "775347652224352258",
//                    author: User(
//                        id: "305243321784336384",
//                        username: "circular",
//                        global_name: "the circlest of them all",
//                        avatar: "fc0914ced252a9754e6ffd3c64823b9b",
//                        discriminator: "0000"
//                    )
//                ))
                ForEach(messages) { message in
                    MessageItem(message: message)
                }
            }
            .scaleEffect(x: 1, y: -1, anchor: .center)
            HStack {
                TextFieldLink(prompt: Text("message...")) {
                    Label("Send", systemImage: "paperplane.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                } onSubmit: { value in
                    //                    let selfmessage = messageSender.sendMessage(message: value, channel: channel)
                    //                    var jsonmessage = try? JSONSerialization.jsonObject(with: selfmessage, options: [])
                    //                    if jsonmessage == nil {
                    //                        print("🔴 Error parsing, is it possible the message didnt actually send?")
                    //                        return
                    //                    }
                    //                    let message = MessageConverter.toMessage(message: jsonmessage as! [String : Any])
                    //                    self.messages.insert(message ?? DefaultMessage.Error, at: 0)
                    let selfmessage = messageSender.sendMessage(message: value, channel: channel)
                    //self.messages.insert(selfmessage, at: 0)
                }
                .buttonStyle(.plain)
                .padding(.all, 6)
                .cornerRadius(5)
            }
        }
        .ignoresSafeArea(edges: .all)
        .onAppear {
            messageFetcher.getMessages(channel: self.channel) {
                messages in
                self.messages = messages
            }
            self.cancellable = Gateway.messageCreateSubject.sink { message in
                //print("[MSGCAN] rec")
                guard let message = message["d"] as? [String: Any] else {
                    return
                }
                let nmessage = MessageConverter.toMessage(message: message)
                //print("[MSGCAN] RECV: \(nmessage.channel_id)")
                //print("[MSGCAN] SELF: \(self.channel.id)")
                if (nmessage?.channel_id == self.channel.id) {
                    //self.messages.append(nmessage)
                    print("[MSGCAN] added new")
                    // append message to the beginning of messages
                    for message in messages {
                        if (message.id) == (nmessage?.id) {
                            return
                        }
                    }
                    self.messages.insert(nmessage ?? DefaultMessage.Error, at: 0)
                }
                //self?.messages.append(message)
            }
        }
        .onDisappear {
            self.cancellable?.cancel()
        }
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages(channel: Channel(id: "1088206126467784826", type: 0, name: "general", parent: "1088206126467784826"))
    }
}
