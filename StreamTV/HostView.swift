//
//  HostView.swift
//  StreamTV
//
//  Created by Jason Dubon on 10/31/23.
//

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

struct HostView: View {
    @Environment(\.dismiss) var dismiss
    @Injected(\.streamVideo) var streamVideo
    @StateObject var state: CallState
    @State var isFullScreen: Bool = UIDevice.current.orientation.isLandscape
    let call: Call
    
    init(call: Call) {
        self.call = call
        _state = StateObject(wrappedValue: call.state)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                GeometryReader { reader in
                    if let first = state.participants.first {
                        VideoRendererView(id: first.id, size: reader.size) { renderer in
                            renderer.handleViewRendering(for: first) { size, participant in }
                        }
                    } else {
                        Color(UIColor.secondarySystemBackground)
                    }
                }
                .ignoresSafeArea()
                
                if !isFullScreen {
                    ChatSection()
                        .frame(height: 350)
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
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            do {
                try await call.join(create: true)
                try await call.goLive()
                if let rtmp = call.state.ingress?.rtmp {
                    let address = rtmp.address
                    let streamKey = rtmp.streamKey
                    print("RTMP url \(address) and streamingKey \(streamKey)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            print("did change")
            guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
            isFullScreen = scene.interfaceOrientation.isLandscape
        }
    }
}

//#Preview {
//    HostView()
//}
