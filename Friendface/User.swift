//
//  User.swift
//  Friendface
//
//  Created by ardano on 18.09.2025.
//

import Foundation

struct User: Codable, Identifiable, Hashable, Equatable {
    var id: String
    var isActive: Bool
    var name: String
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    
}

struct Friend: Codable, Identifiable, Hashable, Equatable {
    var id: String
    var name: String
}

extension User {
    static let example = User(
        id: "12345",
        isActive: true,
        name: "Ardan Özpolat",
        company: "Great Wolf Lodge",
        email: "ardan@example.com",
        address: "Istanbul, Turkey",
        about: "Preview için örnek kullanıcı.",
        registered: Date(),
        tags: ["swift", "music", "ios","swift", "music", "ios","swift", "music", "ios","swift", "music", "ios",],
        friends: [Friend(id: "f1", name: "Alpi"), Friend(id: "f2", name: "OZ4RD")]
    )
}
