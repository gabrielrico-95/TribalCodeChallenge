//
//  FavoritesRealm.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import Foundation
import RealmSwift

class FavoritesRealm: ObservableObject {
    let localDB = RealmManager()
    @Published var favoritesArrayRealm: [Favorites] = []
    
    init() {
        retrieveFromRealm()
    }
    
    func retrieveFromRealm() {
        let favorites = localDB.read(Favorites.self)
        favoritesArrayRealm = Array<Favorites>(favorites)
    }
    
}
