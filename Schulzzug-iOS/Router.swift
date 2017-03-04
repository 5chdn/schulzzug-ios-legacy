//
//  Router.swift
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    case register(Parameters)
    case updateScore(Parameters)
    case fetchScore
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        case .updateScore, .fetchScore:
            return "/me/score"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .updateScore:
            return .put
        case .fetchScore:
            return .get
        }
    }
    
    static let baseURLString = "http://51.15.50.238:8080"
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .register(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .updateScore(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default: break
        }
        
        return urlRequest
    }
}
