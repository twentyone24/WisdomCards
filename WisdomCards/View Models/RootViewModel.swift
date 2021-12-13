//
//  RootViewModel.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import Combine
import SwiftUI

enum ActiveScreen {
    case idle
    case timer
    case card
}

class RootViewModel: ObservableObject {
    
    private var email: String = ""
    
    @Published private(set) var currentScreen: ActiveScreen = .idle {
        didSet {
            print(">>! Active Screen: \(currentScreen)")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    

    
    func subscribe() {
        
    }
    
}
