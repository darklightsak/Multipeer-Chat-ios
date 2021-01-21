//
//  ChatListView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 21/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var chatConnectionManager: ChatConnectionManager
    
    var body: some View {
        ScrollView {
            ScrollViewReader(content: { reader in
                VStack(alignment: .leading, spacing: 20, content: {
                    ForEach(chatConnectionManager.messages) { message in
                        MessageBodyView(message: message)
                            .onAppear {
                                if message == chatConnectionManager.messages.last {
                                    reader.scrollTo(message.id)
                                }
                            }
                    }
                })
                .padding(16)
            })
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
            .environmentObject(ChatConnectionManager())
    }
}
