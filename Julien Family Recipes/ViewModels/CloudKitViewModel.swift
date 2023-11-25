//
//  CloudKitViewModel.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/24/23.
//

import Foundation
import CloudKit

class CloudKitViewModel: ObservableObject {
    
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var recipeName: String = ""
    @Published var recipes: [SingleRecipe] = []
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
        fetchRecipes()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAcountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAcountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
            
        }
    }
 
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func fetchUserRecordID(completionHandler: @escaping @Sendable (CKRecord.ID?, Error?) -> Void) {}
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
    }
    
    func addRecipeTitleButtonPressed() {
        guard !recipeName.isEmpty else { return }
        
        addItem(name: recipeName)

    }
    
    private func addItem(name: String) {
        let newRecipe = CKRecord(recordType: "Recipes")
        
        newRecipe["recipeName"] = name
        saveItem(record: newRecipe)
    }
    
    func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.recipeName = ""
                self?.fetchRecipes()
            }
        }
    }
    
    func fetchRecipes() {
        
        let predicate = NSPredicate(value: true)
     //   let predicate = NSPredicate(format: "RecipeName = %@", argumentArray: ["Oxtail"])
        let query = CKQuery(recordType: "Recipes", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "recipeName", ascending: true)] // Sort ABC Order by name
        let queryOperation = CKQueryOperation(query: query)
      //  queryOperation.resultsLimit = 2 // Max you can get at one time is 100. You have to use a returnedCursor to move it forward by 100 each time.
        
        var returnedRecipes: [SingleRecipe] = []
        
        
        queryOperation.recordMatchedBlock = { (returnedRecordId, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let recipeName = record["recipeName"] as? String else { return }
                returnedRecipes.append(SingleRecipe(recipeName: recipeName, record: record))
            case .failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.recipes = returnedRecipes
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func updateRecipe(recipe: SingleRecipe){
        let record = recipe.record
        record["recipeName"] = "New RecipeName!!!"
        saveItem(record: record)
    }
    
    func deleteRecipe(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let recipe = recipes[index]
        let record = recipe.record
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returenedRecordId, returnedError in
            DispatchQueue.main.async {
                self?.recipes.remove(at: index)
            }
        }
        
    }
    
    
}
