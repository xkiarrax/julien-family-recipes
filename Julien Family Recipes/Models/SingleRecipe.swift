//
//  RecipeModel.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/24/23.
//

import Foundation
import CloudKit

struct SingleRecipe: Hashable {
    let recipeName: String
    let record: CKRecord
}
