//
//  HomeSourceOfTruth.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import SwiftUI

class HomeSourceOfTruth: ObservableObject {
    @Published var photoDataItems = [Unsplash]()
}

class FavoritesSourceOfTruth: ObservableObject {
    @Published var favoriteItemsRealm = [Favorites]()
}
