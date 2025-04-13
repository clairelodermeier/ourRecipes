//  SavedRecipiesView.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject var recipeData: RecipeData
    @State var isLoading: Bool = true

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TopBar(header: "Saved Recipes")
                .padding(.bottom, 0)
    
            if isLoading {
                Spacer()
                Text("Loading saved recipes...")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                Spacer()
                
            } else if recipeData.savedRecipes.isEmpty {
                Spacer()
                Text("No saved recipes yet!")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                Spacer()
                
            } else {
                RecipesView(saved: true)
            }
              
            Spacer()
            
        } // Close VStack
        .onAppear {
            Task {
                isLoading = true
                await recipeData.getRecipes()
                isLoading = false // Done loading
            }
        }
    } // Close body

    
} // Close SavedRecipesView

#Preview {
    SavedRecipesView()
        .environmentObject(RecipeData())
}


