//
//  ItunesError.swift
//  iTunesClient
//
//  Created by Rohit Devnani on 26/8/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation

enum ItunesError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(message: String)
}
