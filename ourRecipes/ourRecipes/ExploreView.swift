//  ExploreView.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/11/25.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var recipeData: RecipeData
    @State var cuisine: String? = nil
    @State var isLoading: Bool = true

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if cuisine != nil {
                ZStack {
                    TopBar(header: "\(cuisine!) Recipes")
                        .padding(.bottom, 0)
                    HStack {
                        Button(action: {
                            cuisine = nil
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.white)
                                .padding(.leading, 20.0)
                                .font(.system(size: 20, weight: .semibold))
                        }
                        Spacer()
                        
                    } // Close HStack
                } // Close ZStack
                
            } else {
                TopBar(header: "Explore Recipes by Cuisine")
                    .padding(.bottom, 0)

            }
            if isLoading {
                Spacer()
                Text("Loading cuisines...")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                Spacer()
            } else if recipeData.cuisines.isEmpty {
                Spacer()
                Text("No cuisines to explore!")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                Spacer()
                
            } else if cuisine == nil {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(recipeData.cuisines.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            Button(action: {
                                cuisine = key
                            }) {
                                HStack(spacing: 10) {
                                    Text(key)
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("\(value.count) recipes")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.gray)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.gray)
                                    
                                } // Close HStack
                                .frame(maxWidth: .infinity)
                                .padding()
                            } // Close Button
                            .border(Color.gray.opacity(0.2), width: 0.5)
                            .background(.white)
                        } // End loop
                        
                    } // Close VStack
                    .padding(0)

                } // Close ScrollView
                .padding(0)
                .refreshable {
                    await recipeData.getRecipes()
                }
                
            } else {
              RecipesView(cuisine: cuisine)
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

    
} // Close ExploreView

#Preview {
    ExploreView()
        .environmentObject(RecipeData())
}

