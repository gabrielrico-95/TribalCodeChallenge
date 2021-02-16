//
//  Favorites.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import Foundation
import RealmSwift

class Favorites: Object, Codable, Identifiable {
    @objc dynamic var id: String = ""
    @objc dynamic var alt_description: String = ""
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var isFavorite: Int = 0
    
    override static func primaryKey() -> String?{
        return "id"
    }
}
