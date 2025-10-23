//
//  EditPetView.swift
//  PawsInfo
//
//  Created by CP on 23/10/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPetView: View {
    
    @Bindable var pet: Pet
    @State private var photosPickerItem: PhotosPickerItem?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            // Image
            
            if let imageData = self.pet.image {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                }
            } else {
                CustomContentUnavailableView(strIcon: "pawprint.circle", title: "No image", description: "Pick an image by tapping select image button")
            }
            
            // Photos Picker
            
            PhotosPicker(selection: self.$photosPickerItem, matching: .images) {
                Label("Select a photo", systemImage: "photo.badge.plus")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .listRowSeparator(.hidden)
            
            // Textfield
            
            TextField("Name", text: self.$pet.name)
                .textFieldStyle(.roundedBorder)
                .font(.title.weight(.light))
            
            
            // Button
            
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .padding()
                    .font(.title3.weight(.medium))
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Edit \(self.pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(of: self.photosPickerItem) { oldValue, newValue in
            Task {
                self.pet.image = try? await photosPickerItem?.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    NavigationStack {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        
        let pet = Pet(name: "Daisy")
        
        EditPetView(pet: pet)
            .modelContainer(container)
    }
}
