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
            Text("Permission Granted? \(CKViewModel.permissionStatus.description.uppercased())")
            Text("Name: \(CKViewModel.userName)")
            Text(CKViewModel.error)
            
            NavigationStack {
                NavigationLink {
                    CKCrudView()
                } label: {
                    Text("Go to CRUDView!")
                        .font(.headline)
                        .foregroundStyle(Color.indigo)
                }
                .padding()
            }
        }
        
    }
        
}

#Preview {
    ContentView()
}
