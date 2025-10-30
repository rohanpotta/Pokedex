//
//  ContentView.swift
//  Pokedex
//
//  Created by Rohan Potta on 10/25/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var tappedPokemon: Pokemon?

    var body: some View {
        NavigationStack {
            VStack {
                // Display tapped Pokémon at the top when selected
                if let tapped = tappedPokemon,
                   let urlString = tapped.imageURL,
                   let url = URL(string: urlString) {
                    VStack {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(tapped.name.capitalized)
                            .font(.title2)
                            .padding(.bottom)
                            .bold()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.bottom)
                }

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(viewModel.pokemons) { pokemon in
                            PokemonCellView(pokemon: pokemon)
                                .onTapGesture {
                                    tappedPokemon = pokemon
                                }
                                .onAppear {
                                    if pokemon == viewModel.pokemons.last {
                                        Task {
                                            await viewModel.loadPokemons()
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.top, 16)
                }
            }
            .navigationTitle(Text("Pokédex"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // Reset selection and reload Pokémon from the start
                    Button {
                        tappedPokemon = nil
                        viewModel.reset()
                        Task { await viewModel.loadPokemons() }
                    } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.red.opacity(0.8))
                }
            }
            .task {
                await viewModel.loadPokemons()
            }
        }
    }
}

struct PokemonCellView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            if let urlString = pokemon.imageURL,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(pokemon.name.capitalized)
                .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
