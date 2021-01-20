//
//  ChatSessionView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//

import SwiftUI

struct ChatSessionView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                print("Join a Chat Session")
            }, label: {
                Label("Join a Chat Session", systemImage: "arrow.up.right.and.arrow.down.left.rectangle")
            })
            
            Button(action: {
                print("Host a Chat Session")
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
