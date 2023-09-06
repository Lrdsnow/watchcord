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
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            List {
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
//                    for message in messages {
//                        if (message.id) == (selfmessage.id) {
//                            return
//                        }
//                    }
                    // self.messages.insert(selfmessage, at: 0)
                    // experimental ^^
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
            
            //
            // subscribes to gateway message create event
            //
//            self.cancellable = Gateway.messageCreateSubject.sink { message in
//                //print("[MSGCAN] rec")
//                guard let message = message["d"] as? [String: Any] else {
//                    return
//                }
//                let nmessage = MessageConverter.toMessage(message: message)
//                //print("[MSGCAN] RECV: \(nmessage.channel_id)")
//                //print("[MSGCAN] SELF: \(self.channel.id)")
//                if (nmessage?.channel_id == self.channel.id) {
//                    //self.messages.append(nmessage)
//                    print("[MSGCAN] added new")
//                    // append message to the beginning of messages
//                    for message in messages {
//                        if (message.id) == (nmessage?.id) {
//                            return
//                        }
//                    }
//                    self.messages.insert(nmessage ?? DefaultMessage.Error, at: 0)
//                }
//                //self?.messages.append(message)
//            }
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                messageFetcher.getMessages(channel: self.channel) {
                    messages in
                    self.messages = messages
                }
                print("fetched messages via timer")
            }
        }
        .onDisappear {
            self.cancellable?.cancel()
            timer?.invalidate()
        }
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages(channel: Channel(id: "1088206126467784826", type: 0, name: "general", parent: "1088206126467784826"))
    }
}
