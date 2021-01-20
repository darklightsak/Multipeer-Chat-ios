//
//  ChatMessage.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import UIKit

struct ChatMessage: Identifiable, Equatable, Codable {
    var id = UUID()
    let displayName: String
    let body: String
    var time = Date()
    
    var isUser : Bool {
        return displayName == UIDevice.current.name
    }
}
