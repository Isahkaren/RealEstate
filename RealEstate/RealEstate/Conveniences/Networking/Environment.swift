//
//  Environment.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

public final class Environment {
    
    public enum API {
        case realEstate
        
        var url: URL {
            switch self {
            case .realEstate:
                return URL(string: "http://private-91146-mobiletask.apiary-mock.com/")!
            }
        }
    }
}
