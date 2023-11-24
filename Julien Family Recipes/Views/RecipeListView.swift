//
//  RecipeListView.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model:RecipeModel
    
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading){
                
                Text("All Recipes")
          
                    .padding(.top, 10)
                    //.font(.largeTitle)
                    .bold()
                    .font(Font.custom("Avenir Heavy", size: 34))
                
                ScrollView {
                    LazyVStack (alignment: .leading){
                        ForEach(model.recipes) { r in
                            
                            NavigationLink(destination: RecipeDetailView(recipe:r), label: {
                                HStack(spacing: 20.0) {
                                    Image(r.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .clipped()
                                        .cornerRadius(5)
                                    
                                    VStack (alignment: .leading){
                                        Text(r.name)
                                            .foregroundColor(.red)
                                            .bold()
                                            .font(Font.custom("Lora-Bold", size: 18))
                                        RecipeHighlights(highlights: r.highlights)
                                            .foregroundColor(.purple)
                                            .font(Font.custom("Lora-MediumItalic", size: 16))
                                    }
                                }
                            })
                            
                        }
                    }
                }
                
            }
            // .navigationBarTitle("All Recipes")
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}


#Preview {
    RecipeListView()
}
