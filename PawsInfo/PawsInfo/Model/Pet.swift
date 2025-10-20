//
//  Pet.swift
//  PawsInfo
//
//  Created by CP on 20/10/25.
//

import SwiftData
import SwiftUI

@Model
class Pet {
    var name: String
    var image: Data?
    
    init(name: String, image: Data? = nil) {
        self.name = name
        self.image = image
    }
}
