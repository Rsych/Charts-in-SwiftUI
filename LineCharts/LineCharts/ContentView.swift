//
//  ContentView.swift
//  LineCharts
//
//  Created by Ryan J. W. Kim on 2022/01/17.
//

import SwiftUI

struct ContentView: View {
    @State private var data = makeDataPoints()
    
    var body: some View {
        LineChart(dataPoints: data, lineColor: .blue, lineWidth: 5, pointColor: .red,  pointSize: 10)
            .frame(width: 300, height: 300)
            .onTapGesture {
                data = Self.makeDataPoints()
            }
    }
    
    static func makeDataPoints() -> [DataPoint] {
        var isGoingUp = true
        var currentValue = 50.0
        
        return (1...20).map { _ in
            if isGoingUp {
                currentValue += Double.random(in: 1...10)
            } else {
                currentValue += -Double.random(in: 1...10)
            }
            
            if isGoingUp {
                if Int.random(in: 0..<10) == 0 {
                    isGoingUp.toggle()
                }
            } else {
                if Int.random(in: 0..<7) == 0 {
                    isGoingUp.toggle()
                }
            }
            
            return DataPoint(value: abs(currentValue))
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DataPoint {
    let value: Double
}

struct LineChartShape: Shape {
    let dataPoints: [DataPoint]
    let pointSize: CGFloat
    let maxValue: Double
    let drawingLines: Bool
    
    init(dataPoints: [DataPoint], pointSize: CGFloat, drawingLines: Bool) {
        self.dataPoints = dataPoints
        self.pointSize = pointSize
        self.drawingLines = drawingLines
        
        let highestPoint = dataPoints.max { $0.value < $1.value }
        maxValue = highestPoint?.value ?? 1
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let drawRect = rect.insetBy(dx: pointSize, dy: pointSize)
        
        let xMultiplier = drawRect.width / CGFloat(dataPoints.count - 1)
        let yMultiplier = drawRect.height / CGFloat(maxValue)
        
        for (index, dataPoint) in dataPoints.enumerated() {
            var x = xMultiplier * CGFloat(index)
            var y = yMultiplier * CGFloat(dataPoint.value)
            
            y = drawRect.height - y
            
            x += drawRect.minX
            y += drawRect.minY
            if drawingLines {
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            } else {
                x -= pointSize / 2
                y -= pointSize / 2
                
                path.addEllipse(in: CGRect(x: x, y: y, width: pointSize, height: pointSize))
            }
        }
        return path
    }
}

struct LineChart: View {
    let dataPoints: [DataPoint]
    var lineColor = Color.primary
    var lineWidth: CGFloat = 2
    
    var pointColor = Color.primary
    var pointSize: CGFloat = 5
    
    var body: some View {
        ZStack {
            if lineColor != .clear {
                LineChartShape(dataPoints: dataPoints, pointSize: pointSize, drawingLines: true)
                    .stroke(lineColor, lineWidth: lineWidth)
            }
            
            if pointColor != .clear {
                LineChartShape(dataPoints: dataPoints, pointSize: pointSize, drawingLines: false)
                    .fill(pointColor)
            }
        } //: ZStack
    }
}
