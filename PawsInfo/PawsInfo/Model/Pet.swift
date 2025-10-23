//
//  Pet.swift
//  PawsInfo
//
//  Created by CP on 20/10/25.
//

import SwiftData
import SwiftUI

// Its a macro that makes this model a persistent model using swift data. This will make pet model equvivalent to NSManageObject's subclass in core data
@Model
class Pet {
    var name: String
    // It's a macro that will allow the image property to be stored outside the database file using external storage for large data.
    @Attribute(.externalStorage) var image: Data?
    
    init(name: String, image: Data? = nil) {
        self.name = name
        self.image = image
    }
}

extension Pet {
    
    @MainActor // (If you dont wanna use @MainActor, you can use DispatchQueue.main.async too - They basically ensure the code runs on main thread)
    static var previewDataContainer: ModelContainer {
        let containerConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let previewDataContainer = try! ModelContainer(for: Pet.self, configurations: containerConfiguration)
        
        previewDataContainer.mainContext.insert(Pet(name: "Daizy"))
        previewDataContainer.mainContext.insert(Pet(name: "Luna"))
        previewDataContainer.mainContext.insert(Pet(name: "Bruno"))
        previewDataContainer.mainContext.insert(Pet(name: "Federick"))
        previewDataContainer.mainContext.insert(Pet(name: "Garry"))
        previewDataContainer.mainContext.insert(Pet(name: "Walter"))
        previewDataContainer.mainContext.insert(Pet(name: "Sasha"))
        previewDataContainer.mainContext.insert(Pet(name: "Tommy"))
        previewDataContainer.mainContext.insert(Pet(name: "Vivi"))
        previewDataContainer.mainContext.insert(Pet(name: "Rocky"))
        
        return previewDataContainer
    }
}
