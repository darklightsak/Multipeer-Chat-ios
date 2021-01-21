//
//  ChatView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 21/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var chatConnectionManager: ChatConnectionManager
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            chatInfoView
            ChatListView()
                .environmentObject(chatConnectionManager)
            messageField
        }
        .navigationBarTitle("Chat", displayMode: .inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Leave") {
                    chatConnectionManager.leaveChat()
                }
            }
        })
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    private var messageField: some View {
        VStack(spacing: 0) {
            Divider()
            TextField("Enter Message", text: $messageText, onCommit: {
                guard !messageText.isEmpty else { return }
                chatConnectionManager.send(messageText)
                messageText = ""
            })
            .padding()
        }
    }
    
    private var chatInfoView: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack {
                Text("People in chat:")
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.headline)
                if chatConnectionManager.peers.isEmpty {
                    Text("Empty")
                        .font(Font.caption.italic())
                        .foregroundColor(Color(UIColor.darkGray))
                }
                else {
                    chatPerticipants
                }
            }
            .padding(.top, 8)
            .padding(.leading, 16)
            Divider()
        }
        .frame(height: 44)
    }
    
    private var chatPerticipants: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(chatConnectionManager.peers, id: \.self) { peer in
                    Text(peer.displayName)
                        .padding(.all, 6)
                        .background(Color(UIColor.darkGray))
                        .foregroundColor(.white)
                        .font(Font.body.bold())
                        .cornerRadius(9)
                }
            }
        })
    }
}

import MultipeerConnectivity
struct ChatView_Previews: PreviewProvider {
    static let chatConnectionManager = ChatConnectionManager()
    
    static var previews: some View {
        NavigationView {
            ChatView()
                .environmentObject(chatConnectionManager)
                .onAppear {
                    chatConnectionManager.peers.append(MCPeerID(displayName: "Test Peer"))
                }
        }
    }
}
