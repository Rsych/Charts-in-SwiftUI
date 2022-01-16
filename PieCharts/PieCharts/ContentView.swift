//
//  ContentView.swift
//  PieCharts
//
//  Created by Ryan J. W. Kim on 2022/01/16.
//

import SwiftUI

struct DataPoint: Identifiable {
    let id: Int
    let value: Double
    let color: Color
    
    init(value: Double, color: Color) {
        self.id = Int.random(in: 1..<Int.max)
        self.value = value
        self.color = color
    }
    
    init(id: Int, value: Double, color: Color) {
        self.id = id
        self.value = value
        self.color = color
    }
}

struct PieSegment: Shape, Identifiable {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var path = Path()
        path.move(to: center)
        path.addRelativeArc(center: center, radius: radius, startAngle: Angle(radians: startAngle), delta: Angle(radians: amount))
        
        return path
    }
    
    let data: DataPoint
    var id: Int { data.id }
    var startAngle: Double
    var amount: Double
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
