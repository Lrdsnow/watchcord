////
// watchcord Watch App
// Created by circular with <3 on 2/8/2023
// please excuse my spaghetti code
//

import Foundation

struct Message: Identifiable {
    var id: String
    var type: Int
    var content: String
    var channel_id: String
    var timestamp: Date
    var author: User
}
