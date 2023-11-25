//
//  CKCrudView.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/24/23.
//

import SwiftUI

struct CKCrudView: View {
    @StateObject var CKCrudViewModel = CloudKitViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Julien Family Recipes 👨🏽‍🍳🥘👩🏽‍🍳")
                    .font(.title2)
                    .padding(.bottom, 20)
                
                recipeTitle
                addRecipeTitle
               
                List {
                    ForEach(CKCrudViewModel.recipes, id: \.self) { r in                        Text(r.recipeName)
                            .onTapGesture {
                                //CKCrudViewModel.updateRecipe(recipe: r)
                            }
                    }
                    .onDelete(perform: CKCrudViewModel.deleteRecipe)
                }
                .listStyle(PlainListStyle())

                
                
            }
            .padding()
            .navigationBarHidden(true)
        }.refreshable {
            CKCrudViewModel.fetchRecipes()
        }
    }
}

#Preview {
    CKCrudView()
}


extension CKCrudView {
    
    private var recipeTitle: some View {
        TextField("Add something here...", text: $CKCrudViewModel.recipeName)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    private var addRecipeTitle: some View {
        Button(action: {
            CKCrudViewModel.addRecipeTitleButtonPressed()
        }, label: {
            Text("Add Recipe Title")
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.purple)
                .cornerRadius(10)
        })
    }
    
}
