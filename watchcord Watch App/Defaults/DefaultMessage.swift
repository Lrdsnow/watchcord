////
// watchcord Watch App
// Created by circular with <3 on 7/8/2023
// please excuse my spaghetti code
//

import Foundation

class DefaultMessage {
    static var Error = Message(
        id: "0",
        type: 0,
        content: "Error",
        channel_id: "0",
        author: User(
            id: "0",
            username: "Error",
            global_name: "Error",
            avatar: "",
            discriminator: "0"
        ))
}
