# **Pokémon Catalogue App (iOS)**


https://github.com/user-attachments/assets/a462fbde-26f6-41fc-9a06-f1e0e1f4ba47


A native iOS application built with **SwiftUI** that displays Generation 1 Pokémon using live data from the [PokéAPI](https://pokeapi.co/). The app features a robust catalogue, a personal backpack system, and full offline support.

## **📱 Features**

### **Core Catalogue**

* **Live Data:** Fetches Generation 1 Pokémon (1–151).  
* **Grid Layout:** Beautiful card-based UI with dynamic gradient backgrounds based on Pokémon types.  
* **Search:** Instant search by Pokémon name.  
* **Sorting:** Sort by ID (Ascending/Descending) or Name (A-Z/Z-A).  
* **Filtering:** Filter displayed Pokémon by specific element types (Fire, Water, Grass, etc.).

### **Personal Backpack & Interactions**

* **Backpack System:** Add or remove Pokémon from your personal collection.  
* **Favorites:** Mark Pokémon as favorites with a heart toggle.  
* **Rating:** Rate Pokémon from 1 to 5 stars.  
* **Persistence:** All user data (Backpack, Favorites, Ratings) is saved locally using UserDefaults.

### **🚀 Offline Capability**

* **Smart Caching:** The app caches the API response to a local JSON file.  
* **Offline Mode:** If the internet is unavailable, the app instantly loads data from the local cache.  
* **Image Caching:** Uses URLCache and a custom RemoteImageView to ensure images remain visible even when offline after being loaded once.

## **🛠 Tech Stack**

* **Language:** Swift 5+  
* **Framework:** SwiftUI  
* **Architecture:** MVVM (Model-View-ViewModel)  
* **Networking:** URLSession with modern Swift Concurrency (async/await).  
* **Persistence:** UserDefaults (User interactions) & FileSystem (API Data Cache).  
* **External Dependencies:** None (Lottie code is included as an optional placeholder).

## **📂 Project Structure**

PokemonApp/  
├── App/  
│   └── PokemonApp.swift       // Entry point & Main Configuration  
├── Models/  
│   ├── PokemonDetail.swift    // Data Model  
│   └── UserData.swift         // Local Persistence Model  
├── Services/  
│   ├── PokeAPIService.swift   // Networking & File Caching  
│   └── BackpackManager.swift  // UserDefaults Manager  
├── ViewModels/  
│   ├── PokemonViewModel.swift // Main Business Logic  
│   └── FilterViewModel.swift  // Search/Sort/Filter State  
└── Views/  
    ├── CatalogueView.swift    // Main Grid  
    ├── BackpackView.swift     // Saved Items Grid  
    ├── Components/  
    │   ├── PokemonCardView.swift  // Expandable Card UI  
    │   ├── RemoteImageView.swift  // Custom Image Loader  
    │   └── FilterSortSheet.swift  // Filter UI  
    └── Splash/  
        └── SplashScreenView.swift

## **⚙️ Installation & Setup**

1. **Clone the repository** (or copy the source files).  
2. **Open in Xcode:**  
   * Ensure you are using Xcode 14.0 or later.  
   * Target iOS 16.0+.  
3. **Run the App:**  
   * Select a Simulator (e.g., iPhone 15 Pro).  
   * Press Cmd \+ R to build and run.

### **Optional Lottie Setup**

The code contains a placeholder for Lottie animations (Splash screen). To enable it:

1. Add the lottie-ios package via Swift Package Manager.  
2. Uncomment the import Lottie and the Lottie-specific code in SplashScreenView.  
3. Add a valid pokeball\_splash.json file to your Asset catalog.

## **🏗 Architecture Decisions**

### **MVVM**

The app strictly follows the Model-View-ViewModel pattern:

* **Views** observe ObservableObjects.  
* **ViewModels** handle business logic (sorting, filtering, toggling favorites) and communicate with Services.  
* **Services** handle raw data fetching and persistence.

### **Separation of Concerns**

* **FilterViewModel:** We separated filtering logic into its own ViewModel. This allows the *Catalogue* and the *Backpack* to have independent search states (e.g., searching "Charizard" in the catalogue doesn't hide items in the Backpack tab).

### **Offline Strategy**

Instead of complex CoreData or SwiftData implementations for a read-heavy API app, we utilized:

1. **JSON File Cache:** The raw API list is saved to the Documents directory. On launch, this file is read first for instant UI rendering.  
2. **Background Sync:** The app silently attempts to fetch fresh data from the API to update the cache.

## **📝 License**

This project is for educational purposes. Data provided by [PokéAPI](https://pokeapi.co/).
