//
//  ChannelItem.swift
//  watchcord Watch App
//
//  Created by circular on 14/6/2023.
//

import SwiftUI

struct ChannelItem: View {
    var channel: Channel
    
    var body: some View {
        HStack {
//            if (channel.type == 5) {
//                Image(systemName: "book.closed.fill")
//            } else {
//                Image(systemName: "number.square.fill")
//            }
            switch (channel.type) {
            case 5:
                Image(systemName: "book.closed.fill")
            case 4:
                Image(systemName: "list.bullet")
            default:
                Image(systemName: "number.square.fill")
            }
            Text(channel.name)
        }
    }
}

struct ChannelItem_Previews: PreviewProvider {
    static var previews: some View {
        ChannelItem(channel: Channel(id: "1088206126467784826", type: 0, name: "general", parent: ""))
    }
}
