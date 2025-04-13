//
//  Recipe.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import Foundation

struct Recipe: Codable, Identifiable{
    var id: String
    var name: String
    var cuisine: String
    var imageURL: URL?
    var sourceURL: URL?
    
}


