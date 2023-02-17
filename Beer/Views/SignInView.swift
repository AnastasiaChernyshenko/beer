//
//  SignInView.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @ObservedObject var vm: SignInViewModel
    
    var body: some View {
        Color.yellowColor
            .ignoresSafeArea()
            .overlay(
                VStack {
                    if userState.isLoading {
                        ActivityIndicator()
                    } else {
                        emailTextField
                        passwordTextField
                        signInButton
                    }
                }.padding()
            )
            .alert(userState.errorText ?? "Error", isPresented: $userState.isShowErrorView) {
                Button("OK", role: .cancel) {
                    userState.isShowErrorView = false
                }
            }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(vm: SignInViewModel())
    }
}

private extension SignInView {
    
    var emailTextField: some View {
        TextField(Constants.email, text: $vm.email)
            .autocapitalization(.none)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
    
    var passwordTextField: some View {
        SecureField(Constants.password, text: $vm.password)
            .autocapitalization(.none)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
    
    var signInButton: some View {
        Button(Constants.signIn) {
            userState.signInUser(userEmail: vm.email, userPassword: vm.password)
        }.disabled(!vm.updateSignInButtonEnable())
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.mainColor)
            .foregroundColor(.white)
    }
}