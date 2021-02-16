//
//  FavoritesContentView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesContentView: View {
    let localDB = RealmManager()
    
    @State private var photoDataItemsRealm: [Favorites] = []
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                let favorites = localDB.read(Favorites.self)
                
                if favorites.isEmpty {
                    
                    LazyVStack{
                        Image(systemName: "camera.metering.unknown")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width/2, height: 200, alignment: .center)
                            .scaledToFill()
                        Text("No tienes ninguna foto favorita agregada todavía. Haz favorita alguna foto y la verás disponible aquí.")
                            .multilineTextAlignment(.center)
                    }
                    
                } else {
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        ForEach(0..<20) { photo in
                            VStack {
                                Image(systemName: "photo")
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                    .shadow(radius: 5)
                                    .frame(width: UIScreen.main.bounds.width/2, height: 200, alignment: .center)
                            }
                        }
                    })
                    
                }
                
            }
            .navigationTitle("Favoritos")
        }.onAppear(perform: {
            declareVariableChanges()
        })
    }
    
    func declareVariableChanges() {
        let favorites = localDB.read(Favorites.self)
        photoDataItemsRealm = Array<Favorites>(favorites)
    }
}

struct FavoritesContentView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesContentView()
    }
}
