//
//  StreamTVApp.swift
//  StreamTV
//
//  Created by Jason Dubon on 10/31/23.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    var streamChat: StreamChat?

    var chatClient: ChatClient = {
        var config = ChatClientConfig(apiKey: .init("p5pn7zubw5ek"))
        config.isLocalStorageEnabled = true
        
        return ChatClient(config: config)
    }()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // The `StreamChat` instance we need to assign
        streamChat = StreamChat(chatClient: chatClient)

        // Calling the `connectUser` functions
        connectUser()

        createChannel()
        
        return true
    }
    
    // The `connectUser` function we need to add.
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ._XXx5_yFx1Nl9rl97ScReA6UER84Sey5RmGohY7bx0I")

        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
                userInfo: .init(id: "luke_skywalker",
                                name: "Luke Skywalker",
                                imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
                token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
    
    private func createChannel() {
        let channelId = ChannelId(type: .livestream, id: "mylivestream")
        
        let channelController = chatClient.channelController(for: channelId)
        
        channelController.synchronize { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

@main
struct StreamTVApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
