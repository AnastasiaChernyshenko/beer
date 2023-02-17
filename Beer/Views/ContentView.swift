//
//  ContentView.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Private properties
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
        Text("authorization.title")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20.0)
    }
    
    var welcomeImage: some View {
        Image.pivoRetroPoster
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300.0, height: 300.0)
            .clipped()
            .padding(.bottom, 75.0)
    }
    
    var signInButton: some View {
        Button("authorization.advanced_user") {
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
        Button("authorization.beginner_alcoholic") {
            showingSignUpPage.toggle()
        }.sheet(isPresented: $showingSignUpPage) {
            SignUpView(vm: SignUpViewModel())
        }
        .foregroundColor(.mainColor)
        .controlSize(.large)
    }
}
