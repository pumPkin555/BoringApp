//
//  ActivityView.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 13.10.2021.
//

import SwiftUI

struct ActivityView: View {
    
    var text: String = ""
    
    var body: some View {
        Text(text)
            .padding(.all)
            .font(.body)
            .foregroundColor(.white)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
