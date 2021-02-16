//
//  HomeViewController.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import SwiftUI

class HomeViewController: UIHostingController<HomeContentView>{
    
    override init(rootView: HomeContentView) {
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension HomeViewController: HomeView {
    func retrievePicturesFromApi() {
    }
    
    func loadPicturesFromApi(picture: [Unsplash]) {
        self.rootView.homeSot.photoDataItems = picture
    }
}
