//
//  Recipe.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//


import Foundation

class Recipe: Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var featured:Bool
    var image:String
    var description:String
    var prepTime:String
    var cookTime:String
    var totalTime:String
    var servings:Int
    var highlights:[String] // an array of strings
    var ingredients:[Ingredient] // an array of the ingredient class
    var directions:[String]

}

class Ingredient: Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var num:Int?
    var denom:Int?
    var unit:String?
    
}

