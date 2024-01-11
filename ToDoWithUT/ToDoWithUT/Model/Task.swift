//
//  Task.swift
//  ToDoWithUT
//
//  Created by Eugene on 11/01/2024.
//

import Foundation

struct Task {
    var title: String
    var description: String?
    private(set) var date: Date?
    let location: Location?
    
    init(title: String, description: String? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.date = Date()
        self.location = location
    }
}

extension Task: Equatable {
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.location == rhs.location 
        { return true }
        return false
    }
}
