////
// watchcord Watch App
// Created by circular with <3 on 7/8/2023
// please excuse my spaghetti code
//

import Foundation

// add RateLimitError and AccessError

class DefaultMessage {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS+00:00"
        return formatter
    }()
    
    static var Error = Message(
        id: "0",
        type: 0,
        content: "Error",
        channel_id: "0",
        timestamp: dateFormatter.date(from: "2023-08-03T03:35:30.187000+00:00")!,
            author: User(
            id: "0",
            username: "Error",
            global_name: "Error",
            avatar: "",
            discriminator: "0"
        )
    )
    
    static var RateLimitError = Message(
        id: "0",
        type: 0,
        content: "Rate Limit!",
        channel_id: "0",
        timestamp: DateFormatter().date(from: "2023-08-03T03:35:30.187000+00:00")!,
            author: User(
            id: "0",
            username: "Error",
            global_name: "Error",
            avatar: "",
            discriminator: "0"
        )
    )
    
    static var AccessError = Message(
        id: "0",
        type: 0,
        content: "You do not have permission to view this channel.",
        channel_id: "0",
        timestamp: DateFormatter().date(from: "2023-08-03T03:35:30.187000+00:00")!,
            author: User(
            id: "0",
            username: "Error",
            global_name: "Error",
            avatar: "",
            discriminator: "0"
        )
    )
}
