//
//  ContentView.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingSignUpPage = false
    @State private var showingLoginPage = false
    
    var body: some View {
        Color.yellowColor
            .ignoresSafeArea()
            .overlay(
                VStack {
                    welcomeText
                    welcomeImage
                    signInButton
                    signUpButton
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    var welcomeText: some View {
        Text(Constants.contentTitle)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
    
    var welcomeImage: some View {
        Image.pivoRetroPoster
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .clipped()
            .padding(.bottom, 75)
    }
    
    var signInButton: some View {
        Button(Constants.advancedUser) {
            showingLoginPage.toggle()
        }.sheet(isPresented: $showingLoginPage) {
            SignInView(vm: SignInViewModel())
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(.mainColor)
    }
    
    var signUpButton: some View {
        Button(Constants.beginnerAlcoholic) {
            showingSignUpPage.toggle()
        }.sheet(isPresented: $showingSignUpPage) {
            SignUpView(vm: SignUpViewModel())
        }
        .foregroundColor(.mainColor)
        .controlSize(.large)
    }
}
