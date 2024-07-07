//
//  Characters.swift
//  RickAndMortyAPI
//
//  Created by Erma on 8/7/24.
//

import Foundation

struct APIResponse: Codable {
    let results: [APIResponseResults]
}

struct APIResponseResults: Codable {
    let name: String
    let image: String
    let status: String
}
