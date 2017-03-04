//
//  Router.swift
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    case register
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        }
    }
    
    static let baseURLString = "https://example.com"
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        return urlRequest
    }
}
