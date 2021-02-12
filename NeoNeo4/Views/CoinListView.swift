//
//  CoinListView.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI
import Combine

struct CoinListView: View {
    @ObservedObject private var viewModel: CoinListViewModel = CoinListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.coins, id: \.self) { viewModel in
                NavigationLink(destination: DetailView(viewModel: viewModel)) {
                    TextCellView(viewModel: viewModel)
                }
            }.onAppear {
                self.viewModel.fetchCoins()
            }.navigationBarTitle("Coins")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}
