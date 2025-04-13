//
//  RecipeCell.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct RecipeCell: View {
    @EnvironmentObject var recipeData: RecipeData
    var recipe: Recipe
    var isSaved: Bool {
        recipeData.savedRecipes.contains(where: { $0.id == recipe.id })
    }
    var body: some View {
            Button(action: {
                if let url = recipe.sourceURL {
                    UIApplication.shared.open(url)
                }
                
            }) {
                
            HStack(alignment: .top) {
                
                ZStack (alignment: .top){
                    Button(action: {
                       recipeData.toggleSaved(recipe: recipe)

                    }) {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.brown)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .cornerRadius(10)
                    
                } // Close ZStack
                .padding(.leading, 10.0)

                VStack(alignment: .leading, spacing: 5.0) {

                    Text(recipe.name)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .padding(.trailing, 20.0)
                    
                    Text(recipe.cuisine)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                } // Close VStack
                
                Spacer()

                AsyncImage(url: recipe.smallImageURL ?? URL(string: "")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "frying.pan.fill")
                            .frame(width: 100.0, height: 100.0)
                            .imageScale(.large)
                        
                    case .success(let image):
                        image
                            .resizable()
                    case .failure:
                        Image(systemName: "frying.pan.fill")
                            .frame(width: 100.0, height: 100.0)
                            .imageScale(.large)
                        
                        
                    @unknown default:
                        Image(systemName: "frying.pan.fill")
                            .frame(width: 100.0, height: 100.0)
                            .imageScale(.large)
                    }
                    
                } // Close AsyncImage
                .foregroundColor(.black.opacity(0.5))
                .background(Color.black.opacity(0.1))
                .frame(width: 100, height: 100)
                
            } // Close HStack
            .padding([.top, .bottom, .trailing])
            
        } // Close Button
        .background(Color.brown.opacity(0.2))
        .cornerRadius(20)

    } //Close body

} // Close RecipeCell


