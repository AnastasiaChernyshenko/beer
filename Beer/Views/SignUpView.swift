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
                .alert(userState.errorText ?? "common.error", isPresented: $userState.isShowErrorView) {
                    Button("common.ok", role: .cancel) {
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
        TextField("authorization.username", text: $vm.username)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20.0)
            .foregroundColor(.black)
    }
    
    var emailTextField: some View {
        TextField("authorization.email", text: $vm.email)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20.0)
            .foregroundColor(.black)
            .autocapitalization(.none)
    }
    
    var passwordTextField: some View {
        SecureField("authorization.password", text: $vm.password)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20.0)
            .foregroundColor(.black)
    }
    
    var confirmPasswordTextField: some View {
        SecureField("authorization.confirm_password", text: $vm.confirmPassword)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 10.0)
            .foregroundColor(.black)
    }
    
    var passwordRuleText: some View {
        Text("authorization.password_rule")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.bottom, 10.0)
    }
    
    var signUpButton: some View {
        Button("authorization.sign_up") {
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
