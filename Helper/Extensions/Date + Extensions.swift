//
//  Date + Extensions.swift
//  Copyright © 2021 Steven Schwedt. All rights reserved.
//

import Foundation

enum DateFormatterStyle: String {
    case basicTimeFormatter = "HH:mm:ss.SS"
    case basicDateTimeFormatter = "MM/DD/YY HH:mm:ss"
}

extension Date {
    
    func string(style: DateFormatterStyle) -> String {
        DateFormatter.formatterForStyle(style: style).string(from: self)
    }
    
    /**
    Returns a string in the format "HH:mm:ss.SS"
     */
    var timestamp: String {
        string(style: .basicTimeFormatter)
    }
    
    /**
    Returns a string in the format "MM/DD/YY HH:mm:ss"
     */
    var dateTimeStamp: String {
        string(style: .basicDateTimeFormatter)
    }
    
    /**
    The current time in the format "HH:mm:ss.SS"
     */
    static var timestamp: String {
        Date().timestamp
    }
}

extension DateFormatter {
    
    private static var styledFormatters: [DateFormatterStyle: DateFormatter] = [:]
    static func formatterForStyle(style: DateFormatterStyle) -> DateFormatter {
        if styledFormatters[style] == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = style.rawValue
            styledFormatters[style] = dateFormatter
        }
        return styledFormatters[style] ?? DateFormatter()
    }
}
