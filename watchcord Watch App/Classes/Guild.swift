//
//  GuildItem.swift
//  watchcord Watch App
//
//  Created by circular on 2/6/2023.
//

import Foundation

struct Guild: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var icon: String
    var owner: Bool
    var permissions: String
    var features: [String]
}
