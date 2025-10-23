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
    
    let gridLayoutColumns : [GridItem] = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120)),
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridLayoutColumns) {
                    GridRow {
                        ForEach(self.arrPets) { pet in
                            NavigationLink(destination: EmptyView()) {
                                VStack {
                                    
                                    if let imageData = pet.image {
                                        if let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(width: 100)
//                                                .padding(.top, 25)
                                        }
                                    } else {
                                        Image(systemName: "pawprint.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100)
                                            .padding(.top, 25)
                                            .foregroundStyle(.quaternary)
                                    }
                                    
                                    Spacer()
                                    Text(pet.name)
                                        .font(.title)
                                        .padding(.vertical)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(self.arrPets.isEmpty ? "" : "Pets")
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
        .modelContainer(Pet.previewDataContainer)
}
