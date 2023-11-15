//
//  ChatSection.swift
//  StreamTV
//
//  Created by Jason Dubon on 10/31/23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ChatSection: View {
    var body: some View {
        ZStack {
            ChatChannelView(channelController:
                                ChatClient(
                                    config: ChatClientConfig(
                                        apiKeyString:
                                            "p5pn7zubw5ek"
                                    )
                                )
                                    .channelController(for: ChannelId(type: .livestream, id: "mylivestream"))
            )
        }
    }
}

#Preview {
    ChatSection()
}
