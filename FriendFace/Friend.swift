//
//  Friend.swift
//  FriendFace
//
//  Created by Marcus Benoit on 11.06.24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Friend: Codable {
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Friend.CodingKeys> = try decoder.container(keyedBy: Friend.CodingKeys.self)
        self.id = try container.decode(String.self, forKey: Friend.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: Friend.CodingKeys.name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: Friend.CodingKeys.self)
        try container.encode(self.id, forKey: Friend.CodingKeys.id)
        try container.encode(self.name, forKey: Friend.CodingKeys.name)
    }
}
