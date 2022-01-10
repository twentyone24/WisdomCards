//
//  WaitingScreen.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import SwiftUI
import Combine

struct WaitingScreen: View {
    @State private var time: String = ""
    @State private var cancellables: Set<AnyCancellable> = []
    private let timeFormatter = DateFormatter.timeFormatter
    
    var body: some View {
        Text(time)
    }
    
    func setTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            // .map { [timeFormatter] in timeFormatter.string(from: $0) }
            .map { [timeFormatter] in
                let time = $0.timeIntervalSince(Date().isToday)
                timeFormatter.string(from: $0)
            }
            .removeDuplicates()
            .sink(receiveValue: { in
                // self?.setTimeInViewModels(time: $0)
                self?.time = $0
            })
            .store(in: &cancellables)
    }
}

struct WaitingScreen_Previews: PreviewProvider {
    static var previews: some View {
        WaitingScreen()
    }
}
