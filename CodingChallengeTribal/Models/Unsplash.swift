//
//  Unsplash.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import Foundation
import ObjectMapper

struct Unsplash: Identifiable, Codable {

    let alt_description: String
    let id: String
    let urls: [String: String]
    
}
