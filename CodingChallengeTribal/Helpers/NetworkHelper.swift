//
//  NetworkHelper.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 14/2/21.
//

import Foundation

class NetworkHelper: NSObject {
    
    class func checkResponse(statusCode:HTTPResponseCode,responseDict:[Any]) -> ApiResponse  {
        switch statusCode {
        case .Success:
            let apiResponse = ApiResponse.init(status: true, response: responseDict, responseType: .Default)
            apiResponse.statusCode = HTTPResponseCode.Success
            return  apiResponse
        case .Unauthorized:
            let apiResponse = ApiResponse.init(status: false, response: responseDict, responseType: .Default)
            apiResponse.statusCode = statusCode
            
            return apiResponse
        default:
            let apiResponse = ApiResponse.init(status: false, response: responseDict, responseType: .Default)
            apiResponse.statusCode = statusCode
            return apiResponse
        }
    }
}
