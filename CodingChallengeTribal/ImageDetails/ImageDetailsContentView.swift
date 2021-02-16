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
                        print("Edit button was tapped")
                    }) {
                        Image(systemName: "heart")
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
}

//struct ImageDetailsContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageDetailsContentView()
//    }
//}
