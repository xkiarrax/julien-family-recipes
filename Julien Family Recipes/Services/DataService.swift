//
//  DataService.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//

import Foundation

class DataService {
    
    // Return an array of recipe objects
    static func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        // Get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Check if pathString is not nil, otherwise return an empty Recipe list, because there's no point in continuing if it can't find the path to data.JSON. Guard statement is a way of making sure something is true before continuing.
        guard pathString != nil else {
            return [Recipe]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)

        
        // Create a data object
        do {
            let data = try Data(contentsOf: url)
            
            // Decode the data with a JSON Decoder
            let decoder = JSONDecoder()
            
            do {
                
                let recipeData = try decoder.decode([Recipe].self, from: data)
                // Add the unique IDs
                for newRecipe in recipeData {
                    newRecipe.id = UUID()
                    
                    // Add unique Id's to receipe ingreidents
                    for ingredient in newRecipe.ingredients {
                        ingredient.id = UUID()
                    }
                }
                
                // Return the recipes
                return recipeData
                
            } catch {
                // Catch error with parsing JSON
                print(error)
            }
            
        } catch {
            // Catch error with getting data
            print(error)
        }
        
        return [Recipe]()
    }
    
}

