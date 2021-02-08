//
//  ServiceHelpers.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

protocol ServiceProviding {
    var rawValue: String { get }
    var baseURLString: String { get }
}
