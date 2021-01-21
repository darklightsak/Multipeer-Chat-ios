//
//  MessageBodyView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import SwiftUI

struct MessageBodyView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4, content: {
                Text(message.body)
                    .font(.body)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(message.isUser ? Color.green : Color(UIColor.systemGray))
                    .cornerRadius(9)
                TimestampView(message: message)
                
            })
        }
    }
}

struct MessageBodyView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
          MessageBodyView(message: ChatMessage(displayName: "User 1", body: "Test"))
          MessageBodyView(message: ChatMessage(displayName: UIDevice.current.name, body: "Test"))
        }
        .padding()
    }
}
