//
//  RecipesView.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/12/25.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipeData: RecipeData
    @State var cuisine: String? = nil
    @State var saved: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    
                    if saved {
                        ForEach(recipeData.savedRecipes) { recipe in
                            
                            RecipeCell(recipe: recipe)
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                    
                    else if cuisine == nil {
                        ForEach(recipeData.recipes) { recipe in
                            
                            RecipeCell(recipe: recipe)
                                .frame(maxWidth: .infinity)
                            
                        }
                    
                    } else {
                        if let recipes = recipeData.cuisines[cuisine!] {
                            
                            ForEach(recipes) { recipe in
                                
                                RecipeCell(recipe: recipe)
                                    .frame(maxWidth: .infinity)
                                
                            }
                        } else {
                            Text("No recipes found!")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(Color.black)

                        }
                    }
 
                } // Close VStack
                .onAppear {
                    Task {
                        await recipeData.getRecipes()
                    }
                }
                .padding([.top, .leading, .trailing], 20.0)
                
            } // Close ScrollView
            .padding(0)
            .refreshable {
                await recipeData.getRecipes()
            }

            Spacer()
            
        } // Close VStack

        .background(.white)

    } // Close body
} // Close ExploreView


