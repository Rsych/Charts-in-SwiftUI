//
//  ContentView.swift
//  BarCharts
//
//  Created by Ryan J. W. Kim on 2022/01/17.
//

import SwiftUI



struct ContentView: View {
    @State private var redAmount = Double.random(in: 10...100)
    @State private var yellowAmount = Double.random(in: 10...100)
    @State private var greenAmount = Double.random(in: 10...100)
    @State private var blueAmount = Double.random(in: 10...100)
    
    var data: [DataPoint] {
        [
            DataPoint(id: 1, value: redAmount, color: .red, title: "Yes"),
            DataPoint(id: 2, value: yellowAmount, color: .yellow, title: "Maybe"),
            DataPoint(id: 3, value: greenAmount, color: .green, title: "No"),
            DataPoint(id: 4, value: blueAmount, color: .blue, title: "N/A")
        ]
    }
    
    var body: some View {
        BarChart(dataPoints: data)
        //            .frame(width: 250, height: 300)
            .onTapGesture {
                withAnimation {
                    redAmount = Double.random(in: 10...100)
                    yellowAmount = Double.random(in: 10...100)
                    greenAmount = Double.random(in: 10...100)
                    blueAmount = Double.random(in: 10...100)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DataPoint: Identifiable {
    let id: Int
    let value: Double
    let color: Color
    let title: String
    
    init(value: Double, color: Color, title: String = "") {
        self.id = Int.random(in: 1..<Int.max)
        self.value = value
        self.color = color
        self.title = title
    }
    
    init(id: Int, value: Double, color: Color, title: String = "") {
        self.id = id
        self.value = value
        self.color = color
        self.title = title
    }
}

struct BarChart: View {
    let dataPoints: [DataPoint]
    let maxValue: Double
    
    init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
        
        let highestPoint = dataPoints.max { $0.value < $1.value }
        maxValue = highestPoint?.value ?? 1
    }
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(1...10, id: \.self) { _ in
                    Divider()
                    Spacer()
                }
            }
            HStack {
                VStack {
                    ForEach((1...10).reversed(), id: \.self) { i in
                        Text(String(Int(maxValue / 10 * Double(i))))
                            .padding(.horizontal)
                            .animation(nil)
                        Spacer()
                    }
                }
                
                ForEach(dataPoints) { data in
                    VStack {
                        Rectangle()
                            .fill(data.color)
                            .scaleEffect(y: CGFloat(data.value / maxValue), anchor: .bottom)
                        //                        .background(Color.orange)
                        
                        Text(data.title)
                            .bold()
                    } //: VStack
                }
            } //: HStack
        } //: ZStack
    }
    
}
