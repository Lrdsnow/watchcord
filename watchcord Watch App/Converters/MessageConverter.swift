////
// watchcord Watch App
// Created by circular with <3 on 7/8/2023
// please excuse my spaghetti code
//

import Foundation

class MessageConverter {
    static func toMessage(message: [String: Any]) -> Message? {
        guard let author = message["author"] as? [String: Any] else {
            print("[MessageConverter] failed author guard check, try unwrapping \"d\" if websocket?")
            return nil
        }
        let nmessage = Message(
            id: message["id"] as! String,
            type: message["type"] as! Int,
            content: message["content"] as! String,
            channel_id: message["channel_id"] as! String,
            author: User(
                id: author["id"] as! String,
                username: author["username"] as! String,
                global_name: author["username"] as! String,
                avatar: author["avatar"] as? String ?? "",
                discriminator: author["discriminator"] as! String
            )
        )
        return nmessage
    }
}
