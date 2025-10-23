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
    @State var path: [Pet] = [Pet]()
    @State private var isEditing: Bool = false
    
    let gridLayoutColumns : [GridItem] = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120)),
    ]
    
    var body: some View {
        NavigationStack(path: self.$path) {
            ScrollView {
                LazyVGrid(columns: gridLayoutColumns) {
                    GridRow {
                        ForEach(self.arrPets) { pet in
                            NavigationLink(value: pet) {
                                VStack {
                                    if let imageData = pet.image {
                                        if let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
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
                                .overlay(alignment: .topTrailing) {
                                    if(self.isEditing) {
                                        Menu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    self.modelContext.delete(pet)
                                                    try? modelContext.save()
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "trash.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 30, height: 30)
                                                .padding(.top, 15)
                                                .padding(.trailing, 10)
                                                .foregroundStyle(.red)
                                                .symbolRenderingMode(.multicolor)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(self.arrPets.isEmpty ? "" : "Pets")
            .navigationDestination(for: Pet.self, destination: EditPetView.init)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            self.isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Pet", systemImage: "plus.circle", action: addNewPet)
                }
            }
        }
        .overlay {
            if(self.arrPets.isEmpty) {
                CustomContentUnavailableView(strIcon: "dog.circle", title: "No data available!", description: "Add data to get started!")
            }
        }
    }
    
    func addNewPet() {
        self.isEditing = false
        let pet = Pet(name: "Best Friend")
        self.modelContext.insert(pet)
        self.path = [pet]
    }
}

#Preview {
    ContentView()
        .modelContainer(Pet.previewDataContainer)
}
