//
//  User.swift
//  FriendFace
//
//  Created by Marcus Benoit on 05.06.24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class User: Codable {
    
    @Attribute(.unique)
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
    // array of Friend
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
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)
    }
    
    //
    var date: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.date(from: registered)
        let date = formatter.date(from: registered) ?? .distantPast
        return date
    }
}

extension ContentView {
    
    func fetchJSON() async throws {
        // create url
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("failed to load url")
            return
        }
        
        // fetch data from that url
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // decode data
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let decodedResponse = try? JSONDecoder().decode([User].self, from: data) else {
            fatalError("failed to decode data")
        }
        
        decodedResponse.forEach {
            modelContext.insert($0)
        }
        
//        for user in decodedResponse {
//            modelContext.insert(user)
//        }
        
        lastFetched = Date.now.timeIntervalSince1970
    }
    
    func clearDatabase() {
        _ = try? modelContext.delete(model: User.self)
    }
    
    func hasExceededTimeLimit() -> Bool {
        let timeLimit = 300 // 5 minutes
        let currentTime = Date.now
        let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
        
        guard let timeDifferenceInMins = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else { return false }
        
        return timeDifferenceInMins >= timeLimit
    }
}
