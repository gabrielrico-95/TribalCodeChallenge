//
//  HomeViewController.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import SwiftUI

class HomeViewController: UIHostingController<HomeContentView>{
    var homePresenter: HomePresenter!
    
    override init(rootView: HomeContentView) {
        super.init(rootView: rootView)
        self.homePresenter = HomePresenter(photosService: ApiService())
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        retrievePicturesFromApi()
    }
    
}

extension HomeViewController: HomeView {
    func retrievePicturesFromApi() {
        homePresenter.getUnsplashImages()
    }
    
    func loadPicturesFromApi(picture: [Unsplash]) {
        self.rootView.homeSot.photoDataItems = picture
//        photoDataItems = picture
    }
}
