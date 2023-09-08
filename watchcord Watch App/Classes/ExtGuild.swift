//
// watchcord Watch App
// Created by circular with <3 on 8/9/2023
// please excuse my spaghetti code
//

import Foundation

struct ExtGuild: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var ownerid: String
    var memberCount: Int
    var onlineCount: Int
}
