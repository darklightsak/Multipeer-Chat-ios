//
//  Formatters.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//  Copyright © 2564 BE Surasak W. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}
