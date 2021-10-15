//
//  BoringStackView.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 13.10.2021.
//

import SwiftUI

struct BoringStackView: View {
    
    var image: String = ""
    var text: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(text)
        }
    }
}

struct BoringStackView_Previews: PreviewProvider {
    static var previews: some View {
        BoringStackView()
    }
}
