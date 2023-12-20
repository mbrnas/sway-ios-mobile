//
//  PostsResponse.swift
//  sway-ios-mobile
//
//  Created by Matija Brnas on 20.12.2023..
//

import Foundation
struct PostsResponse: Decodable {
    var content: [Post]
    var totalPages: Int
    var last: Bool
    // Other properties...
}
