//
//  UserAnnotationView.swift
//  Beer
//
//  Created by mac on 07.12.2022.
//

import SwiftUI

struct UserAnnotationView: View {
    // MARK: - Internal properties
    let imageURL: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                AsyncImage(url: URL(string: imageURL))
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(6.0)
                    .background(Color.white)
                    .cornerRadius(36.0)
            }
            .padding(6.0)
            .background(Color.mainColor)
            .cornerRadius(36.0)
            
            Image.triangleFill
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.mainColor)
                .frame(width: 10.0, height: 10.0)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3.0)
                .padding(.bottom, 40.0)
        }
    }
}

struct UserAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnnotationView(imageURL: "")
    }
}
