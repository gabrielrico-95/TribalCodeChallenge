//
//  ImageDetailsContentView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageDetailsContentView: View {
    var chosenImage: UnsplashPhoto
    
    @State var isFavorite: Bool = false
    
    let localDB = RealmManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack() {
                    WebImage(url: URL(string: chosenImage.urls["thumb"]!))
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
                        setFavoritePicture(chosenPicture: chosenImage)
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 36, height: 36, alignment: .center)
                    }
                    Text(chosenImage.alt_description ?? "no available description")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
                
            }
        } .navigationTitle("Detalles")
    }
    
    func setFavoritePicture(chosenPicture: UnsplashPhoto) {
        if let favPicture = localDB.read(Favorites.self).filter("id='\(chosenImage.id)'").first{
            print("ya existía la foto")
            localDB.delete(favPicture)
            isFavorite = false
        } else {
            localDB.create(createFavoritesObject(chosenPicture: chosenPicture))
            isFavorite = true
            print("agregando a favoritas")
        }
    }
    
    func createFavoritesObject(chosenPicture: UnsplashPhoto) -> Favorites {
        let favorite = Favorites()
        favorite.id = chosenPicture.id
        favorite.photoUrl = chosenPicture.urls["thumb"] ?? ""
        favorite.alt_description = chosenPicture.alt_description ?? ""
        return favorite
    }
}

//struct ImageDetailsContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageDetailsContentView()
//    }
//}
