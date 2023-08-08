//
//  Channel.swift
//  watchcord Watch App
//
//  Created by circular on 19/6/2023.
//

import Foundation

struct Channel: Identifiable {
    var id: String
    var type: Int
    var name: String
    var parent: String
}
