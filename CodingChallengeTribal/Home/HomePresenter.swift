//
//  HomePresenter.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

class HomePresenter: BasePresenter {
    
    typealias View = HomeView
    var homeView: HomeView?
    var disposeBag = DisposeBag()
    
    fileprivate let photosService : ApiService
    
    var photosObservable: Disposable?
    
    init(photosService: ApiService) {
        self.photosService = photosService
    }
    
    func attachView(view: HomeView) {
        self.homeView = view
    }
    
    func detachView() {
        
    }
    
    func destroy() {
        disposeBag = DisposeBag()
        photosObservable?.dispose()
    }
    
    func getUnsplashImages() {
//        photosService.getUnsplashDataAPI(completion: { response in
//            switch response {
//            case .success(let courses):
//                self.homeView?.loadPicturesFromApi(picture: courses)
//            case .failure(let err):
//                print("Failed to fetch courses:", err)
//            }
//        })
        
//        if !photosService.rxGetUnsplashDataResponse.hasObservers {
//            
//            photosObservable = photosService.rxGetUnsplashDataResponse.subscribe(onNext: {(response) in
//                if response.status {
//                    
//                    let jsonData = JSON(response.data)
//                    if let jsonArray = jsonData.arrayObject {
//                        let unsplashData = Mapper<Unsplash>().mapArray(JSONObject: jsonArray)
//                        self.homeView?.loadPicturesFromApi(picture: unsplashData!)
//                    }
//                    
//                }
//            }, onError: {(error) in
//                
//            }, onCompleted: {
//                
//            })
//            
//            photosObservable?.disposed(by: disposeBag)
//            
//        }
        
    }
    
}
