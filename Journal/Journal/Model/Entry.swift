//
//  Entry.swift
//  Journal
//
//  Created by Chris Withers on 1/11/21.
//

import Foundation
class Entry: Codable {
    
    var title: String
    var body: String
    let timeStamp: Date
    
    init(title: String, body: String, timeStamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timeStamp = timeStamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.timeStamp == rhs.timeStamp
    }
    

    
}




