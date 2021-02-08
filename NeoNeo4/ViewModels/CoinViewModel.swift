//
//  CoinViewModel.swift
//  NeoNeo3
//
//  Created by Steve Schwedt on 2/3/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
    
    @Published var coins: [CoinViewModel] = []
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = CryptoResponse.performRequest().sink(receiveCompletion: { _ in
        }, receiveValue: { cryptoContainer in
            self.coins = cryptoContainer.data.coins.map( { CoinViewModel(coin: $0) })
        })
    }
}

struct CoinViewModel: Hashable, TextDisplayViewModel {
    let coin: Coin
    
    var displayString: String {
        let price = (((Double(coin.price) ?? 0.0) * 100.0).rounded() / 100)
        
        return "\(coin.name) - \(price)"
    }
}
