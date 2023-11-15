//
//  ContentView.swift
//  StreamTV
//
//  Created by Jason Dubon on 10/31/23.
//

import SwiftUI
import StreamVideo

struct Secrets {
    static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiTWFyYV9KYWRlIiwiaXNzIjoicHJvbnRvIiwic3ViIjoidXNlci9NYXJhX0phZGUiLCJpYXQiOjE2OTg3NTUwMDYsImV4cCI6MTY5OTM1OTgxMX0.hzIEyRP7o_xC5fd9PG4_TO7h5U0BdBGkTm9LJ_OhBUw"
    static let userId = "Mara_Jade"
    static let callId = "cjSwabr1qJNb"
    static let apiKey = "hd8szvscpxvd"
}

struct ContentView: View {
    @State var streamVideo: StreamVideo
    let call: Call
    
    init() {
        let user = User(id: Secrets.userId, name: "tutorial")
        
        let streamVideo = StreamVideo(apiKey: Secrets.apiKey, user: user, token: UserToken(rawValue: Secrets.userToken))
        let call = streamVideo.call(callType: .livestream, callId: Secrets.callId)
        self.streamVideo = streamVideo
        self.call = call
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Host") {
                    HostView(call: call)
                }
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .foregroundStyle(.purple)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThickMaterial)
                )
                
                NavigationLink("View") {
                    LivestreamView(callId: Secrets.callId)
                }
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .foregroundStyle(.purple)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThickMaterial)
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.purple)
        }
    }
}

#Preview {
    ContentView()
}
