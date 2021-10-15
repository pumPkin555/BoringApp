//
//  TypeView.swift
//  BoringAppWatch Extension
//
//  Created by Ivanov Viktor on 13.10.2021.
//

import SwiftUI

struct TypeView: View {
    
    var text: String = ""
    var typeDictionary: [String : Color] = [
        "education"    : Color.blue,
        "recreational" : Color.green,
        "social"       : Color.orange,
        "diy"          : Color.secondary,
        "charity"      : Color.red,
        "cooking"      : Color.yellow,
        "relaxation"   : Color.purple,
        "music"        : Color.pink,
        "busywork"     : Color.gray
    ]
    
    var body: some View {
        Text(text)
            .foregroundColor(typeDictionary[text] ?? Color.white)
            .background(
                RoundedCorners(tl: 6, tr: 0, bl: 0, br: 6).fill(Color.clear) // typeDictionary[text]
            )
            .clipped()
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
    }
}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()
        
        return path
    }
}
