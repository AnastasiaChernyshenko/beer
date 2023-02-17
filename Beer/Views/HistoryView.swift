//
//  HistoryView.swift
//  Beer
//
//  Created by Anastasia on 19.10.2022.
//

import SwiftUI

struct HistoryView: View {
    // MARK: - Internal properties
    @ObservedObject var viewModel: HistoryViewModel
    
    // MARK: - Initialization
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.drinkingBuddies.isEmpty {
            emptyView
        } else {
            listView
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: HistoryViewModel(drinkingBuddies: []))
    }
}

private extension HistoryView {
    var emptyView: some View {
        Color.yellowColor.ignoresSafeArea().overlay {
            VStack {
                Image.ooopsIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300.0, maxHeight: 300.0)
                Text("map.no_one_found")
                    .font(.headline)
            }
        }
    }
    
    var listView: some View {
        List {
            ForEach($viewModel.drinkingBuddies.indices, id: \.self) { index in
                let historyUser = viewModel.drinkingBuddies[index]
                HStack(alignment: .center, spacing: 5.0) {
                    VStack(alignment: .leading, spacing: 5.0) {
                        AsyncImage(url: URL(string: historyUser.picture))
                            .scaledToFill()
                            .frame(width: 80.0, height: 80.0)
                            .cornerRadius(10.0)
                    }
                    
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(historyUser.name)
                            .font(.title2)
                            .padding(5.0)
                        
                        Text(historyUser.email)
                            .font(.subheadline)
                            .padding(5.0)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.deleteDrinkingUserFromDB(atIndexSet: indexSet)
            }
        }
    }
}
