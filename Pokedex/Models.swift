//
//  Models.swift
//  Pokedex
//
//  Created by Rohan Potta on 10/25/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let name: String
    let url: String
    var id: String { name }
    var imageURL: String?
}

struct PokemonDetails: Codable {
    struct Sprites: Codable {
        let front_default: String?
    }
    let sprites: Sprites
}
