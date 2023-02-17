//
//  ActivityIndicator.swift
//  Beer
//
//  Created by mac on 16.02.2023.
//

import SwiftUI

struct ActivityIndicator: View {
    // MARK: - Private properties
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5.0, height: geometry.size.height / 5.0)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5.0, 0.25, 1.0, duration: 1.5)
                        .repeatForever(autoreverses: false), value: UUID())
            }
        }
        .foregroundColor(Color.mainColor)
        .frame(width: 100.0, height: 100.0)
        .aspectRatio(1.0, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}

private extension ActivityIndicator {
    // MARK: - Private methods
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1.0 - CGFloat(Float(index)) / 5.0 : 0.2 + CGFloat(index) / 5.0)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10.0 - geometry.size.height / 2.0
    }
}
