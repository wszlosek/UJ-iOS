//
//  ContentView.swift
//  9_Drawing
//
//  Created by Wojciech Szlosek on 04/02/2022.
//

import SwiftUI

// Challenge 1
struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
       
        path.move(to: CGPoint(x: rect.midX * 2/3, y:rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX * 2/3, y: rect.maxY * 1/3))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * 1/3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 1/3))
        path.addLine(to: CGPoint(x: rect.midX * 4/3, y: rect.maxY * 1/3))
        path.addLine(to: CGPoint(x: rect.midX * 4/3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX * 2/3, y: rect.maxY))
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Trapezoid: Shape {
    var insetAmount: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                   
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(Double(rows), Double(columns))
        }

        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }

}

struct ContentView: View {
        @State private var myLineWidth = 5.0
        @State private var bigLine = false
        
        var body: some View {
            Arrow()
                .stroke(Color.red, style: StrokeStyle(lineWidth: myLineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
            
            // Challenge 2
                .onTapGesture {
                    withAnimation {
                        bigLine.toggle()
                        myLineWidth = bigLine ? 25.0 : 5.0
                    }
                }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
