//
//  UserAnnotationView.swift
//  Beer
//
//  Created by mac on 07.12.2022.
//

import SwiftUI

struct UserAnnotationView: View {
    
    let imageURL: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                AsyncImage(url: URL(string: imageURL))
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.white)
                    .cornerRadius(36)
            }
            .padding(6)
            .background(Color.mainColor)
            .cornerRadius(36)
            
            Image.triangleFill
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.mainColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct UserAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnnotationView(imageURL: "")
    }
}
