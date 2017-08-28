//
//  Endpoint.swift
//  iTunesClient
//
//  Created by Rohit Devnani on 23/8/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation

// By creating these 3 components we will get our URL
protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var querryItems: [URLQueryItem] { get }
}

extension Endpoint {
    // So, let's add a computed property that uses the base path and query items to return a URL request object containing the valid URL. To achieve this, we're going to use another struct that's part of the foundation framework, URLComponents. URLComponents is a structure designed to parse URLs and to construct URLs from their various parts.
    var urlComponents: URLComponents {
         var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = querryItems
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url! // I want this to crash if i havent configured properly.
        return URLRequest(url: url)
    }
}

enum Itunes {
    case search(term: String, media: ItunesMedia?)
    case lookup(id: Int, entity: ItunesEntity?)
    
}

extension Itunes: Endpoint {
    var base: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/search"
        case.lookup: return "/lookup"
        }
    }
    
    var querryItems: [URLQueryItem] {
        switch self {
        case .search(let term, let media):
            var result = [URLQueryItem]()
            
            let searchTermItem = URLQueryItem(name: "term", value: term)
            result.append(searchTermItem)
            
            if let media = media {
                let mediaItem = URLQueryItem(name: "media", value: media.description)
                result.append(mediaItem)
                
                if let entityQueryItem = media.entityQueryItem {
                    result.append(entityQueryItem)
                }
                
                if let attributeQueryItem = media.attributeQueryItem {
                    result.append(attributeQueryItem)
                }
                
            }
            
            return result
        case .lookup(let id, let entity):
            return [
                URLQueryItem(name: "id", value: id.description),
                URLQueryItem(name: "entity" , value: entity?.entityName)
            ]
        }
    
    }
}




















