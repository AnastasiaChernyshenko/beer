//
//  UserPreviewView.swift
//  Beer
//
//  Created by mac on 07.12.2022.
//

import SwiftUI

struct UserPreviewView: View {
    // MARK: - Internal properties
    @ObservedObject var vm: MapViewModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16.0) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8.0) {
                infoButton
                nextButton
            }
        }
        .padding(20.0)
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.ultraThinMaterial)
                .offset(y: 65.0)
        )
        .cornerRadius(10.0)
    }
}

extension UserPreviewView {
    private var imageSection: some View {
        ZStack {
            AsyncImage(url: URL(string: vm.selectedUser?.picture.large ?? ""))
                .scaledToFill()
                .frame(width: 100.0, height: 100.0)
                .cornerRadius(10)
        }
        .padding(6.0)
        .background(Color.white)
        .cornerRadius(10.0)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4.0) {
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
            Text("map.info")
                .font(.headline)
                .frame(width: 125.0, height: 35.0)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        ZStack {
            Button {
                vm.nextButtonPressed()
            } label: {
                Text("map.next")
                    .font(.headline)
                    .frame(width: 125.0, height: 35.0)
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
