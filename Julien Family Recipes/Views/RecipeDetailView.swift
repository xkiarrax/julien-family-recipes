//
//  RecipeDetailView.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    @State var selectedServingSize = 2
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                // MARK: Recipe Name
                Text(recipe.name)
          
                    .padding(.top, 10)
                    .font(Font.custom("Avenir Heavy", size: 34))
                    .bold()
                
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 200, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                
                // MARK: Serving Sixe Picker
                VStack (alignment: .leading) {
                    Text("Select your Serving Size")
                        .font(Font.custom("Lora-BoldItalic", size: 17))
                        .foregroundColor(.purple)
                    Picker("", selection: $selectedServingSize){
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                        Text("10").tag(10)
                        Text("12").tag(12)
                        Text("14").tag(14)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                .frame(width: 350)
                
                
                // MARK: Ingredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(Font.custom("Lora-Bold", size: 18))
                        .padding([.top, .bottom], 10.0)
                    
                    ForEach(recipe.ingredients) { item in
                        Text("• " + RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingSize) + " " + item.name.lowercased())
                            .padding(.bottom, 1)
                            .font(Font.custom("Lora-Regular", size: 17))
                    }
                }.padding(.horizontal)
                
                // MARK: Divider
                Divider().padding(.top, 10)
                
                // MARK: Directions
                VStack(alignment: .leading){
                    Text("Directions")
                        .font(Font.custom("Lora-Bold", size: 25))
                        .padding(.bottom, 5)
                        .foregroundColor(Color.purple)
                    
                    ForEach(0..<recipe.directions.count, id:\.self) { index in
                        Text(String(index + 1) + ". " + recipe.directions[index])
                            .padding(.bottom, 5.0)
                            .font(Font.custom("Lora-Regular", size: 17))
                        
                    }
                }.padding(.horizontal)
            }
        }
    }
}


//#Preview {
//    // Create a dummy recipe and pass it into the detail view so that we can see preview.
//
//}
