//
//  Font.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import UIKit
import SwiftUI

extension Font {

    static func MantiSansBlack(size: CGFloat) -> Font {
        return Font.custom("Manti Sans Black", size: size)
    }

    static func MantiSansBlackItalic(size: CGFloat) -> Font {
        return Font.custom("Manti Sans Black Italic", size: size)
    }

    static func MantiSansBoldItalic(size: CGFloat) -> Font {
        return Font.custom("Manti Sans Bold Italic", size: size)
    }

    static func MantiSansBold(size: CGFloat) -> Font {
        return Font.custom("Manti Sans Bold", size: size)
    }

    static func MantiSansFixedWidth(size: CGFloat) -> Font {
        return Font.custom("Manti Sans Fixed Width", size: size)
    }

    static func RubikItalicVariable(size: CGFloat) -> Font {
        return Font.custom("Rubik Italic Variable", size: size)
    }

    static func RubikVariable(size: CGFloat) -> Font {
        return Font.custom("Rubik Variable", size: size)
    }

}

typealias CustomFontDescription = (String, CGFloat)
var fontDescriptions: [UIFont.TextStyle: CustomFontDescription] = [

    .largeTitle: ("Manti Sans Black", 22.0),
    .title1: ("Manti Sans Black", 20.0),
    .title2: ("Manti Sans Black", 17.0),
    .title3: ("Manti Sans Black", 16.0),
    .headline: ("Manti Sans Black", 15.0),
    .callout: ("Manti Sans Black", 17.0),
    .subheadline: ("Manti Sans Black", 13.0),
    .body: ("Manti Sans Black", 12.0),
    .footnote: ("Manti Sans Black", 11.0),
    .caption1: ("Manti Sans Black", 22.0),
    .caption2: ("Manti Sans Black", 20.0)
]

