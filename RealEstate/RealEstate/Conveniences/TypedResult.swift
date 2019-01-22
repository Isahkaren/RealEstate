//
//  TypedResult.swift
//  RealEstate
//
//  Created by Isabela Karen on 23/12/18.
//  Copyright © 2018 Isabela Karen. All rights reserved.
//

import Foundation

public typealias Result<T> = TypedResult<T, Error>
public enum TypedResult<T, E> {
    case success(T)
    case error(E)
}
