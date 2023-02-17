//
//  HistoryView.swift
//  Beer
//
//  Created by Anastasia on 19.10.2022.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: HistoryViewModel
    
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
                    .frame(maxWidth: 300, maxHeight: 300)
                Text(Constants.noOneFound)
                    .font(.headline)
            }
        }
    }
    
    var listView: some View {
        List {
            ForEach($viewModel.drinkingBuddies.indices, id: \.self) { index in
                let historyUser = viewModel.drinkingBuddies[index]
                HStack(alignment: .center, spacing: 5) {
                    VStack(alignment: .leading, spacing: 5) {
                        AsyncImage(url: URL(string: historyUser.picture))
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(historyUser.name)
                            .font(.title2)
                            .padding(5)
                        
                        Text(historyUser.email)
                            .font(.subheadline)
                            .padding(5)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.deleteDrinkingUserFromDB(atIndexSet: indexSet)
            }
        }
    }
}
