//
//  UserProfile.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/19/23.
//

import Foundation

struct UserProfile: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var userUUID: UUID
    var bio: String?
    var techInterests: String?
    var posts: [Post]
}
