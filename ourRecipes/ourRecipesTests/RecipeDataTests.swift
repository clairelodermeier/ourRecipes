//
//  RecipeDataTests.swift
//  ourRecipes
//
//  Created by Claire Lodermeier on 4/13/25.
//

import XCTest
@testable @preconcurrency import ourRecipes

final class RecipeDataTests: XCTestCase {

    func testGetRecipes() async {
        let goodDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let recipeData = RecipeData()

        await recipeData.getRecipes(from: goodDataURL)
        
        DispatchQueue.main.async {
            XCTAssertFalse(recipeData.recipes.isEmpty, "Recipes should not be empty!")
            XCTAssertFalse(recipeData.cuisines.isEmpty, "Cuisines should not be empty!")
            XCTAssertTrue(recipeData.errorMessage == nil, "ErrorMessage should be nil!")
        }
    }
    func testGetRecipesMalformed() async {
        let malformedDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        let recipeData = RecipeData()

        await recipeData.getRecipes(from: malformedDataURL)
        
        DispatchQueue.main.async {
            XCTAssertTrue(recipeData.recipes.isEmpty, "Recipes should be empty!")
            XCTAssertTrue(recipeData.cuisines.isEmpty, "Cuisines should be empty!")
            XCTAssertFalse(recipeData.errorMessage == nil, "ErrorMessage should not be nil!")
        }
    }
    
    func testGetRecipesEmpty() async {
        let emptyDataURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        let recipeData = RecipeData()

        await recipeData.getRecipes(from: emptyDataURL)
        
        DispatchQueue.main.async {
            XCTAssertTrue(recipeData.recipes.isEmpty, "Recipes should be empty!")
            XCTAssertTrue(recipeData.cuisines.isEmpty, "Cuisines should be empty!")
            XCTAssertTrue(recipeData.errorMessage == nil, "ErrorMessage should be nil!")
        }
    }

}
