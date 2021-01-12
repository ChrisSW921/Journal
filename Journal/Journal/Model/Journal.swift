//
//  Journal.swift
//  Journal
//
//  Created by Chris Withers on 1/12/21.
//

import Foundation

class Journal: Codable {
    let title: String
    var entries: [Entry] = []
    
    init(title: String) {
        self.title = title
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return rhs.title == lhs.title && lhs.entries == rhs.entries
    }
    
    
}
