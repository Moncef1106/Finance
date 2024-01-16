//
//  Item.swift
//  Financechecker
//
//  Created by Moncef Elmzouri on 09/01/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
