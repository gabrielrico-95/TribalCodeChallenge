//
//  FavoriteImageDetailsContentView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 16/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteImageDetailsContentView: View {
    let localDB = RealmManager()
    var chosenFavoriteImage: Favorites
    
    @State private var isFavorite: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack() {
                    WebImage(url: URL(string: chosenFavoriteImage.photoUrl))
                        .placeholder(Image(systemName: "photo"))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .padding(.top, -75)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                        .shadow(radius: 5)
                    Button(action: {
                        print("Setting favoriteImage")
                        setFavoritePicture(chosenPicture: chosenFavoriteImage)
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 36, height: 36, alignment: .center)
                    }
                    Text(chosenFavoriteImage.alt_description)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
                
            }
        } .navigationTitle("Detalles")
    }
    
    func setFavoritePicture(chosenPicture: Favorites) {
//        if let favPicture = localDB.read(Favorites.self).filter("id='\(chosenPicture.id)'").first{
//            print("ya existía la foto")
//            print(favPicture)
//            if chosenPicture.id !=  ""{
//                localDB.delete(favPicture)
//            }
//            isFavorite = false
//        } else {
//            localDB.create(createFavoritesObject(chosenPicture: chosenPicture))
//            isFavorite = true
//            print("agregando a favoritas")
//        }
    }
    
    func createFavoritesObject(chosenPicture: Favorites) -> Favorites {
        let favorite = Favorites()
        favorite.id = chosenPicture.id
        favorite.photoUrl = chosenPicture.photoUrl
        favorite.alt_description = chosenPicture.alt_description
        return favorite
    }
}

//struct FavoriteImageDetailsContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteImageDetailsContentView()
//    }
//}
