//
//  View.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import SwiftUI

// MARK: - VIEW
extension View {
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    @ViewBuilder func removeIf(_ remove: Bool) -> some View {
        if !remove {
            self.hidden()
        } else {
            self
        }
    }
    
    func gradientForeground(colors: [Color], startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: startPoint, endPoint: endPoint))
            .mask(self)
    }
    
    var erasedToAnyView: AnyView {
        AnyView(self)
    }
    
    func themeFont(_ textStyle: UIFont.TextStyle) -> ModifiedContent<Self, CustomFont> {
        return modifier(CustomFont(textStyle: textStyle))
    }
    
    var getSafeArea: UIEdgeInsets {
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return null
        }
        return safeArea
    }
    
    @ViewBuilder
    public func `if`<Content: View>(
        _ condition: @autoclosure @escaping () -> Bool,
        @ViewBuilder content: (Self) -> Content
    ) -> some View {
        if condition() {
            content(self)
        } else {
            self
        }
    }
    
    func applyIfWithAnyView<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T) -> AnyView {
        if condition() {
            return apply(self).erasedToAnyView
        } else {
            return self.erasedToAnyView
        }
    }
    
    @ViewBuilder
    public func `if`<Value, Content: View>(
        `let` value: Value?,
        @ViewBuilder content: (_ view: Self, _ value: Value) -> Content
    ) -> some View {
        if let value = value {
            content(self, value)
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func ifNot<Content: View>(
        _ notCondition: @autoclosure @escaping () -> Bool,
        @ViewBuilder content: (Self) -> Content
    ) -> some View {
        if notCondition() {
            self
        } else {
            content(self)
        }
    }
    
    @ViewBuilder
    public func then<Content: View>(@ViewBuilder content: (Self) -> Content) -> some View {
        content(self)
    }
}


struct CustomFont: ViewModifier {
    let textStyle: UIFont.TextStyle
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    func body(content: Content) -> some View {
        
        guard let fontDescription = fontDescriptions[textStyle] else {
            
            print("textStyle nicht vorhanden: \(textStyle)")
            return content.font(.system(.body))
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let fontSize = fontMetrics.scaledValue(for: fontDescription.1)
        
        return content.font(.custom(fontDescription.0, size: fontSize))
    }
    
}

