//
//  UserPreviewView.swift
//  Beer
//
//  Created by mac on 07.12.2022.
//

import SwiftUI

struct UserPreviewView: View {
    
    @ObservedObject var vm: MapViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                infoButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

extension UserPreviewView {
    private var imageSection: some View {
        ZStack {
            AsyncImage(url: URL(string: vm.selectedUser?.picture.large ?? ""))
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(vm.selectedUser?.name.first ?? "")
                .font(.title2)
                .fontWeight(.bold)
            Text(vm.selectedUser?.name.last ?? "")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var infoButton: some View {
        Button {
            vm.shitUser = vm.selectedUser
        } label: {
            Text(Constants.info)
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        ZStack {
            Button {
                vm.nextButtonPressed()
            } label: {
                Text(Constants.next)
                    .font(.headline)
                    .frame(width: 125, height: 35)
            }
            .buttonStyle(.bordered)
        }
    }
}
//struct UserPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPreviewView()
//    }
//}
