//
//  Comments.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/6/23.
//

import Foundation

struct Comment {
    var commentID: Int
    var body: String
    var created: Date
    var userID: UUID
    var userName: String
}
