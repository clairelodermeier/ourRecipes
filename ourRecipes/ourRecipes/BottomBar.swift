//
//  BottomBar.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct BottomBar: View {
    var body: some View {
        TabView {
            AllRecipesView()
                .tabItem {
                    Image(systemName: "book.pages.fill")
                    Text("All Recipes")
                }
            
            ExploreView(cuisine: nil)
                .tabItem {
                    Image(systemName: "globe.americas.fill")
                    Text("Cuisines")
                }
            
            SavedRecipesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Saved")
                }

        }
        .tint(Color.black)

    }
}

#Preview {
    BottomBar()
        .environmentObject(RecipeData())
}
