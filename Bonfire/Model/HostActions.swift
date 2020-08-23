//
//  HostActions.swift
//  Bonfire
//
//  Created by James on 22/8/20.
//  Copyright © 2020 ipse. All rights reserved.
//

import Foundation


class HostAction{
    private var actions: [String] = ["Ban", "Challange", "JS Challange"]
    private var ipAddress: Int
    init(ipAddress: Int){
        self.ipAddress = ipAddress
    }
    func getActions() -> [String]{
        return actions
    }
}
