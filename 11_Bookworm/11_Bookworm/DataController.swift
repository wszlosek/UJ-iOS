//
//  DataController.swift
//  11_Bookworm
//
//  Created by Wojciech Szlosek on 07/02/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failer to load: \(error.localizedDescription)")
            }
            
        }
    }
}
