# Pokedex iOS App

A simple, SwiftUI-based Pokédex app that fetches Pokémon data from the [PokéAPI](https://pokeapi.co/) and displays it in an interactive grid.

---

## Features

- **Pokémon Grid** – Displays Pokémon in a scrollable, adaptive `LazyVGrid`. Each Pokémon is shown in a card-style view with its name and image.  
- **Tap to Highlight** – When a Pokémon is tapped, it appears at the top center of the screen in a larger card.  
- **Pagination** – Fetches Pokémon in batches of 20. As you scroll near the bottom, additional Pokémon are loaded dynamically.  
- **Reset Button** – A prominent red “Reset” button allows the user to clear the current selection and reload the Pokémon list from scratch.  
- **Concurrency** – Uses Swift Concurrency to fetch Pokémon details and images concurrently for faster loading.  
- **Responsive UI** – Adaptive grid layout ensures cards resize appropriately across different screen sizes.

---

## UI Choices

- **Cards for Pokémon** – Each Pokémon in the grid is displayed as a card with a white background, corner radius, and shadow to match Pokémon Cards.  
- **Top Pokémon Card** – When a Pokémon is selected, it appears at the top with a shadow and a slightly larger image to emphasize selection.  
- **LazyVGrid** – Chosen over `HStack` or `VStack` because it efficiently handles large datasets with dynamic layout and on-demand cell loading.  
- **Reset Button** – Positioned in the toolbar for accessibility, styled as a red button with an icon for visual purposes.

---

## Architecture & Design

- **MVVM Pattern**
  - `PokemonViewModel` manages fetching Pokémon data, handling pagination, and updating the UI.  
  - `PokemonService` handles network requests for the Pokémon list and Pokémon details.  
  - `ContentView` and `PokemonCellView` handle UI rendering and user interaction.

- **Async Image Loading** – Uses SwiftUI’s `AsyncImage` to load images directly from URLs with a `ProgressView` placeholder while loading.  
- **Pagination Logic** – The view model keeps track of the offset (amount loaded) and only fetches the next batch of Pokémon when the user scrolls to the last Pokémon in the grid.

---

## Future Improvements

- **Image Caching** – Implement local image caching to prevent re-downloading them each time they appear.  
- **Persistent Storage** – Save Pokémon data locally using CoreData or SQLite for offline access.  
- **Search Functionality** – Add a search bar to find a Pokémon by name.  
- **UI Enhancements** – Add animated transitions, custom styles, and better theming for the Pokémon Cards.  

---

## Installation & Usage

1. Clone the repository:

```bash
git clone https://github.com/rohanpotta/Pokedex.git
cd Pokedex
