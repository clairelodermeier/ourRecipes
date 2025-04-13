//
//  AllRecipesView.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct AllRecipesView: View {
    @EnvironmentObject var recipeData: RecipeData
    @State var isLoading: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopBar(header: "All Recipes")
                .padding(.bottom, 0)
                        
            if let errorMessage = recipeData.errorMessage {
                Spacer()
                HStack {
                    Spacer()
                    Text(errorMessage)
                        .foregroundColor(.black)
                        .frame(alignment: .center)
                        .font(.largeTitle)
                    Spacer()
                }
                Spacer()
            } else if isLoading {
                Spacer()
                HStack {
                    Spacer()
                    Text("Loading Recipes...")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                    Spacer()
                }
                Spacer()
            } else if recipeData.recipes.isEmpty {
                Spacer()
                HStack {
                    Spacer()
                    Text("No recipes found!")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                    Spacer()
                }
                Spacer()
            }
            else {
                RecipesView()

            } // End else

            Spacer()
        } // Close VStack
        .onAppear {
            Task {
                isLoading = true
                await recipeData.getRecipes()
                isLoading = false // Done loading
            }
        }
        .background(.white)

    } // Close body
} // Close AllRecipesView 

#Preview {
    AllRecipesView()
        .environmentObject(RecipeData())

}
