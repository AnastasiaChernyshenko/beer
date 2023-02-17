//
//  SignUpView.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @ObservedObject var vm: SignUpViewModel
    
    var body: some View {
        HStack {
            Color.yellowColor
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        if userState.isLoading {
                            ActivityIndicator()
                        } else {
                            usernameTextField
                            emailTextField
                            passwordTextField
                            confirmPasswordTextField
                            passwordRuleText
                            signUpButton
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
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(vm: SignUpViewModel())
    }
}

private extension SignUpView {
    
    var usernameTextField: some View {
        TextField(Constants.username, text: $vm.username)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
    
    var emailTextField: some View {
        TextField(Constants.email, text: $vm.email)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
            .autocapitalization(.none)
    }
    
    var passwordTextField: some View {
        SecureField(Constants.password, text: $vm.password)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
    
    var confirmPasswordTextField: some View {
        SecureField(Constants.confirmPassword, text: $vm.confirmPassword)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 10)
            .foregroundColor(.black)
    }
    
    var passwordRuleText: some View {
        Text(Constants.passwordRuleText)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.bottom, 10)
    }
    
    var signUpButton: some View {
        Button(Constants.signUp) {
            userState.signUpUser(name: vm.username, userEmail: vm.email, userPassword: vm.password)
        }
        .disabled(!vm.updateSignUpButtonEnable())
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(.mainColor)
        .foregroundColor(.white)
    }
}
