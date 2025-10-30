//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Rohan Potta on 10/25/25.
//

import SwiftUI
import Combine

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    private let service = PokemonService()
    private var apiOffset = 0
    private var isLoading = false
    private let limit = 20
    
    func loadPokemons() async {
        // Prevent multiple simultaneous loads during pagination
        guard !isLoading else { return }
        isLoading = true
        
        do {
            var newPokemons = try await service.fetchPokemonList(limit: limit, offset: apiOffset)
            
            // Fetch images concurrently instead of sequentially
            await withTaskGroup(of: (Int, String?).self) { group in
                for (index, pokemon) in newPokemons.enumerated() {
                    group.addTask {
                        do {
                            let details = try await self.service.fetchPokemonDetails(url: pokemon.url)
                            return (index, details.sprites.front_default)
                        } catch {
                            return (index, nil)
                        }
                    }
                }
                
                for await (index, imageURL) in group {
                    newPokemons[index].imageURL = imageURL
                }
            }
            
            pokemons.append(contentsOf: newPokemons)
            apiOffset += limit
        } catch {
            print("Error loading pokemons: \(error)")
        }
        isLoading = false
    }
    
    func reset() {
        pokemons.removeAll()
        apiOffset = 0
    }
}
