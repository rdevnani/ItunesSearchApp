//
//  QueryItemProvider.swift
//  iTunesClient
//
//  Created by Rohit Devnani on 26/8/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation

protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}

