//
//  RecipeData.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/12/25.
//

import Foundation

class RecipeData: ObservableObject {
    static let shared = RecipeData()
    
    @Published var recipes: [Recipe] = []
    @Published var cuisines: [String: [Recipe]] = [:]
    @Published var errorMessage: String?
    @Published var savedRecipes: [Recipe] = []
    
    // fetches list of recipes
    func getRecipes(from url: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!) async {
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let jsonArray = json["recipes"] as? [[String: Any]] else { return }

            // create local lists of recipes and cuisines in the async thread
            var localRecipes: [Recipe] = []
            var localCuisines: [String: [Recipe]] = [:]
                        
            for jsonItem in jsonArray {
                
                // parse required json data
                guard let id = jsonItem["uuid"] as? String,
                      let name = jsonItem["name"] as? String,
                      let cuisine = jsonItem["cuisine"] as? String else {
                    // handle malformed data
                    updateErrorMessage()
                    return
                }
                
                // add new cuisines to local list
                if !(localCuisines.keys.contains(cuisine)) {
                    localCuisines[cuisine] = []
                }
                
                // create Recipe from required json data
                var recipe = Recipe(id: id, name: name, cuisine: cuisine)
                
                // parse optional json data and add it to recipe
                if let imageString = jsonItem["photo_url_small"] as? String,
                   let imageURL = URL(string: imageString) {
                    recipe.imageURL = imageURL
                }
                if let sourceURLString = jsonItem["source_url"] as? String,
                    let sourceURL = URL(string: sourceURLString) {
                    recipe.sourceURL = sourceURL
                }
                
                // append recipe to the local list of recipes
                localRecipes.append(recipe)
                
                // sort recipe into local cuisine list
                localCuisines[cuisine]?.append(recipe)
      
            }
            
            updateRecipes(localRecipes)
            updateCuisines(localCuisines)
            
        } catch {
            DispatchQueue.main.async {
                print(error)
            }
        }
    }
    
    // empty local list of recipes into recipe list on main thread
    private func updateRecipes(_ localRecipes: [Recipe]) {
        DispatchQueue.main.async {
            RecipeData.shared.recipes = localRecipes
        }
    }
    
    // empty local list of cuisines into cuisine list on main thread
    private func updateCuisines(_ localCuisines: [String: [Recipe]]) {
        DispatchQueue.main.async {
            RecipeData.shared.cuisines = localCuisines
        }
    }
        
    // updates the error message to display on the UI for bad data
    private func updateErrorMessage() {
        DispatchQueue.main.async {
            RecipeData.shared.errorMessage = "Cannot load recipes. Please try again later."
        }
    }
    
    // saves or unsaves recipe
    func toggleSaved(recipe: Recipe) {
        if let index = savedRecipes.firstIndex(where: { $0.id == recipe.id}) {
            savedRecipes.remove(at: index)
        } else {
            savedRecipes.append(recipe)
        }
        
    }
    

    
}


