//
//  ContentView.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var CKViewModel = CloudKitViewModel()
    var body: some View {
        VStack {
            Text("IS SIGNED IN: \(CKViewModel.isSignedInToiCloud.description.uppercased())")
            Text(CKViewModel.error)
        }
        
    }
        
}

#Preview {
    ContentView()
}
