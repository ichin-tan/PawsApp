//
//  CurtomContentUnavailableView.swift
//  PawsInfo
//
//  Created by CP on 23/10/25.
//

import SwiftUI

struct CustomContentUnavailableView : View {
    
    var strIcon: String
    var title: String
    var description: String
        
    var body: some View {
        ContentUnavailableView {
            Image(systemName: strIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Text(title)
                .font(.title)
            
        } description: {
            Text(description)
        }
    }
    
}

#Preview {
    CustomContentUnavailableView(strIcon: "cat.circle", title: "No data available!", description: "Add data to get started!")
}
