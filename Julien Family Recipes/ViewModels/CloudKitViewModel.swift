//
//  CloudKitViewModel.swift
//  Julien Family Recipes
//
//  Created by Kiarra Julien on 11/24/23.
//

import Foundation
import CloudKit

class CloudKitViewModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    
    init() {
        getiCloudStatus()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                
                switch returnedStatus {
                case .available:
                    break
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.localizedDescription
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAcountNotDetermined.localizedDescription
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.localizedDescription
                default:
                    break
                }
            }
        }
    }
    
    enum CloudKitError: LocalizedError {
        case iCloudAccountNotFound
        case iCloudAcountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUknown
    }
    
}
