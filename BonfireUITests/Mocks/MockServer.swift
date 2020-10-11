//
//  MockServer.swift
//  BonfireUITests
//
//  Created by Matthew Samuel on 10/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation
import Swifter

struct MockServer {
    public let server: HttpServer = HttpServer()

    public func addRoute(route: String, jsonData: Data, requestType: RequestType) {
        
        var json: [String: Any]
        try! json = JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            HttpResponse.ok(.json(json as AnyObject))
        }
        
        switch requestType {
        case .post:
            // pass
            server.post[route] = response
        case .get:
            server.get[route] = response
        case .put:
            server.put[route] = response
        }
    }
}

enum RequestType {
    case get
    case post
    case put
}
