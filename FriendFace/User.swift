//
//  User.swift
//  FriendFace
//
//  Created by Marcus Benoit on 05.06.24.
//

import Foundation
import SwiftData

struct User: Codable, Identifiable, Hashable {
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var address: String
    var about: String
    var registered: String
    // array of Strings
    var tags: [String]
    
    var friends: [Friend]
    
    enum CodingKeys: String, CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    // not important for the computed property
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
        self.registered = try container.decode(String.self, forKey: .registered)
    }
    

    
    struct Friend: Codable, Hashable, Identifiable {
        var id: String = ""
        var name: String = ""
    }
    
    //
    var date: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.date(from: registered)
        let date = formatter.date(from: registered) ?? .now
        return date
    }
}

