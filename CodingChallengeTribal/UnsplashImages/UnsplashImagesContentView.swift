//
//  UnsplashImagesContentView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct UnsplashImagesContentView: View {
    
    @ObservedObject var unsplashRandomImages = UnsplashApiService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                    ForEach(unsplashRandomImages.photoArray, id: \.id) { photo in
                        VStack {
                            NavigationLink(
                                destination: ImageDetailsContentView(chosenImage: photo),
                                label: {
                                    WebImage(url: URL(string: photo.urls["thumb"]!))
                                        .placeholder(Image(systemName: "photo"))
                                        .resizable()
                                        .indicator(.activity)
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                        .onAppear(perform: {
                                            unsplashRandomImages.UnsplashApiCall(currentItem: photo)
                                        })
                                        .shadow(radius: 5)
                                })
                        }
                    }
                })
                
            }
            .navigationTitle("Home")
        }
    }
}

struct UnsplashImagesContentView_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashImagesContentView()
    }
}
