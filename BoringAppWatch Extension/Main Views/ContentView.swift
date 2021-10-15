//
//  ContentView.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 13.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var offset: CGSize = CGSize.zero
    private var model: WatchModel = WatchModel()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 2)
            HStack {
                    Spacer().frame(width: 15)
                    WatchCardView()
                        .background(Color.clear)
                        .cornerRadius(20)
                        .background(RoundedCorners(tl: 15, tr: 15, bl: 15, br: 15)
                                        .stroke(Color.white,
                                                style: StrokeStyle(lineWidth: 1,
                                                                   lineCap: .round,
                                                                   lineJoin: .round)
                                        )
                        )
                        .rotationEffect(.degrees(Double(self.offset.width / 2)))
                        .offset(x: offset.width * 5, y: 0)
                        .gesture(
                            DragGesture()
                                .onChanged({ (gesture) in
                                    self.offset = gesture.translation
                                })
                                .onEnded({ (gesture) in
                                    if (abs(self.offset.width) >= 25) {
                                        self.model.sendToiPhone()
                                    }
                                    self.offset = .zero
                                })
                        )
                    Spacer().frame(width: 15)
            }
            Spacer().frame(height: 2)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(model: WatchModel())
//    }
//}
