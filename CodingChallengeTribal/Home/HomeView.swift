//
//  HomeView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import Foundation

protocol HomeView {
    func retrievePicturesFromApi()
    mutating func loadPicturesFromApi(picture: [Unsplash])
}
