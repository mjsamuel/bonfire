//
//  AboutUsViewModel.swift
//  Bonfire
//
//  Created by Matthew Samuel on 5/10/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation
import AVKit

struct AboutUsViewModel {
    
    public var team: [TeamMember]
    
    
    init() {
        self.team = [
            TeamMember(name: "Dylan Sbogar", id: "s3718036"),
            TeamMember(name: "James Cockshott", id: "s3656070"),
            TeamMember(name: "Kurt Invernon", id: "s3663139"),
            TeamMember(name: "Matthew Samuel", id: "s3717393")
        ]
    }
    
}

/**
 Helper struct to store and pass around team member information
 
 - Parameters
 - name: The name of the country
 - id: The number of requests for that country
 */
struct TeamMember {
    public let name: String
    public let id: String
    public var image: UIImage?
    
    init(name: String, id: String, image: UIImage? = nil) {
        self.name = name
        self.id = id
        self.image = image
    }
}
