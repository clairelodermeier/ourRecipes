//  SavedRecipiesView.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject var recipeData: RecipeData

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TopBar(header: "Saved Recipes")
                .padding(.bottom, 0)
    
            if recipeData.savedRecipes.isEmpty {
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
                await recipeData.getRecipes()
            }
        }
    } // Close body

    
} // Close SavedRecipesView

#Preview {
    SavedRecipesView()
        .environmentObject(RecipeData())
}


