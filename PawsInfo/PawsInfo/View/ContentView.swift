//
//  ContentView.swift
//  PawsInfo
//
//  Created by CP on 19/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var arrPets: [Pet]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                EmptyView()
            }
        }
        .overlay {
            if(self.arrPets.isEmpty) {
                CustomContentUnavailableView(strIcon: "dog.circle", title: "No data available!", description: "Add data to get started!")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
