//
//  PawsInfoApp.swift
//  PawsInfo
//
//  Created by CP on 19/10/25.
//

import SwiftUI
import SwiftData

@main
struct PawsInfoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
