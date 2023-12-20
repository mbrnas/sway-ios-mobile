//
//  Post.swift
//  sway-ios-mobile
//
//  Created by Matija Brnas on 20.12.2023..
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let datePosted: String
    let likes: Int
    let dislikes: Int
    let user: User
    let categoryName: String
}

// Equatable extension for Post
extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id // Comparison based on unique ID
    }
}
