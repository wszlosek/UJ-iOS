//
//  _1_BookwormApp.swift
//  11_Bookworm
//
//  Created by Wojciech Szlosek on 07/02/2022.
//

import SwiftUI

@main
struct _1_BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
