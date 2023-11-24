//
//  RecipeFeaturedView.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        
        let featuredRecipes = model.recipes.filter({ $0.featured })
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 34))
                .bold()
            
            GeometryReader { geo in
                
                TabView (selection: $tabSelectionIndex){
                    // Loop through each recipe
                    ForEach (0..<featuredRecipes.count) { index in
                        
                        // Recipe Card Button
                        Button(action: {
                            // Show the recipe detail sheet
                            self.isDetailViewShowing = true
                        }, label: {
                            // Recipe Card
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack(spacing: 0) {
                                    Image(featuredRecipes[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(featuredRecipes[index].name)
                                        .padding(5)
                                }
                            }
                        }).tag(index)
                        
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                            .cornerRadius(15)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 10, x: -5, y: 5)
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
            }
            
            VStack (alignment: .leading, spacing: 10) {
                Text("Preparation Time:")
                    .font(Font.custom("Lora-Bold", size: 18))
                Text(model.recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Lora-MediumItalic", size: 16))
                    .foregroundColor(.purple)
                Text("Highlights:")
                    .font(Font.custom("Lora-Bold", size: 18))
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
                    .font(Font.custom("Lora-MediumItalic", size: 16))
                    .foregroundColor(.purple)
            }
            .padding([.leading, .bottom])
        }
        .sheet(isPresented: $isDetailViewShowing ) {
            // Show the Recipe Detail View
            RecipeDetailView(recipe: featuredRecipes[tabSelectionIndex])
            
        }
    }
}

#Preview {
    RecipeFeaturedView()
}
