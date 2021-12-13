//
//  Double.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation

// MARK: - DOUBLE
extension Double {
    var prettyPrinted: String {
        
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current, self/1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current, self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "%.0f", locale: Locale.current, self)
    }
}
