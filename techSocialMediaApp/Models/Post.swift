//
//  Post.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 6/30/23.
//

import Foundation

struct Post: Codable {
    var postid: Int
    var title: String
    var body: String
    var authorUserName: String
    var authorUserId: UUID
    var likes: Int
    var userLiked: Bool
    var numComments: Int
    var createdDate: String
   // var comments = [String]
}

struct CreatePostBody: Codable {
    var userSecret: String
    var post: [String: String]
}
struct EditPostBody: Codable {
    var userSecret: String
    var post: [String: String]
    var postid: Int
}

