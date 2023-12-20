//
//  SignInResponse.swift
//  codechronicles-ios
//
//  Created by Matija Brnas on 19.12.2023..
//

import Foundation
struct SignInResponse: Codable {
    var token: String
    var refreshToken: String
}
