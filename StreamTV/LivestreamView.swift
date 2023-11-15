//
//  LivestreamView.swift
//  StreamTV
//
//  Created by Jason Dubon on 10/31/23.
//

import SwiftUI
import StreamVideoSwiftUI
import StreamChat
import StreamChatSwiftUI
import EffectsLibrary

struct LivestreamView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedEmoji: Character = "🔥"
    @State var shouldAnimate = false
    @State var isFullScreen: Bool = UIDevice.current.orientation.isLandscape
    var emojis: [Character] = ["🔥", "💀", "🚀", "👀", "🗑️"]
    let callId: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                LivestreamPlayer(type: .livestream, id: callId)
                    .frame(height: isFullScreen ? UIScreen.main.bounds.height : 200, alignment: .top)
                
                if !isFullScreen {
                    HStack {
                        ForEach(emojis, id: \.self) { emoji in
                            Button(String(emoji)) {
                                selectedEmoji = emoji
                                shouldAnimate = true
                            }
                            .font(.largeTitle)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThickMaterial)
                    )
                    .padding()
                    
                    ChatSection()
                }
            }
            
            HStack {
                Button("", systemImage: "chevron.backward") {
                    dismiss()
                }
                .font(.title2)
                
                Spacer()
                
                Button("", systemImage: "arrow.up.left.and.arrow.down.right") {
                    isFullScreen.toggle()
                }
                .font(.title2)
            }
            .padding(.horizontal)
            .padding(.top, isFullScreen ? 32 : 0)
            
            if shouldAnimate {
                ConfettiView(config: ConfettiConfig(
                                                    content: [
                                                        .emoji(selectedEmoji, 1.0)
                                                    ],
                                                    intensity: .high
                                    )
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        shouldAnimate = false
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .frame(maxHeight: .infinity)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            print("did change")
            guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
            isFullScreen = scene.interfaceOrientation.isLandscape
        }
    }
}

//#Preview {
//    LivestreamView()
//}
