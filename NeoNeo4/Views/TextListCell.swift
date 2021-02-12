//
//  TextListCell.swift
//  NeoNeo4
//
//  Created by Steve Schwedt on 2/7/21.
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import SwiftUI

struct TextCellView: View {
    var viewModel: TextDisplayViewModel
    
    var body: some View {
        Text(viewModel.displayString)
    }
}
