//
//  RecipeTabView.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//

import SwiftUI

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        
        TabView {
            
            RecipeFeaturedView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Featured")
                    }
                }
            
            RecipeListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
        }.environmentObject(RecipeModel())
        
    }
}


#Preview {
    RecipeTabView()
}
