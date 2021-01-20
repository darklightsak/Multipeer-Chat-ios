//
//  TimestampView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import SwiftUI

struct TimestampView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(spacing: 2) {
            Text(message.displayName)
            Text("@")
            Text(message.time, formatter: DateFormatter.timestampFormatter)
            if !message.isUser {
                Spacer()
            }
        }
        .font(.caption)
        .foregroundColor(.gray)
    }
}

struct TimestampView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TimestampView(message: ChatMessage(displayName: "User 1", body: "Test"))
            TimestampView(message: ChatMessage(displayName: UIDevice.current.name, body: "Test"))
        }
        .padding()
    }
}
