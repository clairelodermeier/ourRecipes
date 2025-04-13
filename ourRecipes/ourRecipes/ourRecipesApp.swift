//
//  ourRecipesApp.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

@main
struct ourRecipesApp: App {
    @StateObject private var recipeData = RecipeData.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeData)
        }
    }
}
