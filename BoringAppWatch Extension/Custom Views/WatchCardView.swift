//
//  WatchCardView.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 13.10.2021.
//

import SwiftUI
import WatchConnectivity

struct WatchCardView: View {
    
    @ObservedObject var model = WatchModel()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 0.5)
            HStack {
                Spacer().frame(width: 4.5)
                TypeView(text: model.model?[0] ?? "")
                Spacer()
            }
            Spacer()
            ActivityView(text: model.model?[1] ?? "Open app on your iPhone)")
            Spacer()
            HStack {
                Spacer().frame(width: 5)
                BoringStackView(image: (Int(model.model?[2] ?? "0") ?? 0) < 2 ? "person.circle" : "person.2.circle",
                                text: model.model?[2] ?? "0")
                Spacer()
                BoringStackView(image: "dollarsign.circle", text: model.model?[3] ?? "0.0")
                Spacer().frame(width: 5)
            }
        }
    }
}

//struct WatchCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchCardView(model: WatchModel())
//    }
//}
