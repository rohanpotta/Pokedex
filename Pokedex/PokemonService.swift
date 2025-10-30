//
//  PokemonService.swift
//  Pokedex
//
//  Created by Rohan Potta on 10/25/25.
//

import Foundation

class PokemonService {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return decoded.results
    }
    
    func fetchPokemonDetails(url: String) async throws -> PokemonDetails {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PokemonDetails.self, from: data)
        return decoded
    }
}
