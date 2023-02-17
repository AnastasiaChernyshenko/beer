//
//  SignInView.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI
import Firebase

struct SignInView: View {
    // MARK: - Internal properties
    @ObservedObject var vm: SignInViewModel
    
    // MARK: - Private properties
    @EnvironmentObject private var userState: UserStateViewModel
    
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
            .alert(userState.errorText ?? "common.error", isPresented: $userState.isShowErrorView) {
                Button("common.ok", role: .cancel) {
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
        TextField("authorization.email", text: $vm.email)
            .autocapitalization(.none)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20.0)
    }
    
    var passwordTextField: some View {
        SecureField("authorization.password", text: $vm.password)
            .autocapitalization(.none)
            .padding()
            .background(.white)
            .cornerRadius(5.0)
            .padding(.bottom, 20.0)
    }
    
    var signInButton: some View {
        Button("authorization.sign_in") {
            userState.signInUser(userEmail: vm.email, userPassword: vm.password)
        }.disabled(!vm.updateSignInButtonEnable())
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.mainColor)
            .foregroundColor(.white)
    }
}
