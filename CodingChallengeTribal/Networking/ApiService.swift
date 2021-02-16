//
//  ApiService.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON
import RealmSwift


class ApiService {
    let rxGetUnsplashDataResponse = PublishSubject<ApiResponse>()
    let disposeBag = DisposeBag()
    let unsplashKey = "1LSMlcnuw07rNL8Tr5kri20_yr6bXnAmbqsMxsn_J5Y"
    
//    func getUnsplashDataAPI() {
//
//        let url = "https://api.unsplash.com/users/alexmotoc/photos?order_by=latest&client_id=\(unsplashKey)"
//
//        RxAlamofire
//            .requestJSON(.get,
//                                url,
//                                parameters: nil,
//                                encoding: JSONEncoding.default,
//                                headers: nil)
//            .debug()
//            .subscribe(onNext: { (headerResponse, json) in
//            let jsonData = JSON(json)
//            let statusCode:Int = headerResponse.statusCode
//
//            if let dict = jsonData.arrayObject {
//                let code = HTTPResponseCode(rawValue:statusCode) ?? .Unknown
//                let apiResponse = NetworkHelper.checkResponse(statusCode: code, responseDict: dict)
//                self.rxGetUnsplashDataResponse.onNext(apiResponse)
//            }
//
//
//
//        }, onError: {  (error) in
//            print("API Response \(url)\nError:\(error.localizedDescription)")
//            self.rxGetUnsplashDataResponse.onError(error)
//        }, onDisposed: {
//            print("Diposing API")
//        }).disposed(by: disposeBag)
//    }
}

class UnsplashPhoto: Identifiable, Codable {
    var id: String
    var alt_description: String?
    var urls: [String: String]
}

class UnsplashApiService: ObservableObject {
    let unsplashKey = "1LSMlcnuw07rNL8Tr5kri20_yr6bXnAmbqsMxsn_J5Y"
    @Published var photoArray: [UnsplashPhoto] = []
    
    init() {
        UnsplashApiCall()
    }
    
    func UnsplashApiCall(currentItem: UnsplashPhoto? = nil) {
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        
        let urlString = "https://api.unsplash.com/photos/random/?count=30&client_id=\(unsplashKey)"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            // check response status and err
            guard let data = data else { return }
            do {
                let photoData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                print(photoData)
                DispatchQueue.main.async {
                    self.photoArray.append(contentsOf: photoData)
                }
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    
    func shouldLoadMoreData(currentItem: UnsplashPhoto? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (photoArray.count - 4)...(photoArray.count-1) {
            if n >= 0 && currentItem.id == photoArray[n].id {
                return true
            }
        }
        return false
    }
    
    func postContactInformationApi(model: ContactDetails, completion:@escaping (Bool, String) -> ()) {
        let Url = String(format: "https://nube11.com/bamfit/node?_format=json")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                "type"          : "contacto",
                
                "field_nombre_completo": [
                    "value"     : model.fullName,
                ],
                
                "field_fecha_de_nacimiento": [
                    "value"     : model.dateOfBirth,
                ],
                
                "field_correo_electronico": [
                    "value"     : model.email,
                ],
                
                "field_mensaje": [
                    "value"     : model.additionalMessage
                ]
                
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        completion(true, "¡Éxito! Se ha enviado tu información. En breve, estaremos en contacto contigo.")
                    } catch {
                        print(error.localizedDescription)
                        completion(false, error.localizedDescription)
                    }
                }
            }.resume()
    }
}
