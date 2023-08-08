////
// watchcord Watch App
// Created by circular with <3 on 2/8/2023
// please excuse my spaghetti code
//

import Foundation

struct User: Identifiable {
    var id: String
    var username: String
    var global_name: String
    var avatar: String
    var discriminator: String
}
