//
//  ChatSessionView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//

import SwiftUI

struct ChatSessionView: View {
    @ObservedObject private var chatConnectionManager = ChatConnectionManager()
    
    var body: some View {
        VStack(spacing: 30) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                chatConnectionManager.join()
            }, label: {
                Label("Join a Chat Session", systemImage: "arrow.up.right.and.arrow.down.left.rectangle")
            })
            
            Button(action: {
                chatConnectionManager.host()
            }, label: {
                    Label("Host a Chat Session", systemImage: "plus.circle")
            })
        }
        .navigationTitle("Chat")
    }
}

struct ChatSessionView_Previews: PreviewProvider {
    static var previews: some View {
        ChatSessionView()
    }
}
