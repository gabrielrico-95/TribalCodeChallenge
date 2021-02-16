//
//  HomeContentView.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeContentView: View {
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    
    let tabBarImageNames = ["house", "heart", "person"]
    
    @ObservedObject var homeSot: HomeSourceOfTruth
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action: {shouldShowModal.toggle()}, label: {
                            Text("Fullscreen cover")
                        })
                    
                })
                
                switch selectedIndex {
                case 0:
                    UnsplashImagesContentView()
                case 1:
                    FavoritesContentView()
                default:
                    ContactInfoContentView()
                }
                
            }
            
//            Spacer()
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<3) { num in
                    Button(action: {
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        Image(systemName: tabBarImageNames[num])
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        
                        
                        Spacer()
                    })
                    
                }
            }
            
            
        }
    }
}

//struct HomeContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeContentView()
//    }
//}

