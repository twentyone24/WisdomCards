//
//  FlipClockVM.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import Combine
import SwiftUI

class ClockViewModel {

    var timer: Timer?
    @Published var duration: Double
    
    init(duration: Double = 18.0 /* 3600.0 */) {
        self.duration = duration
        checkIfWaitScreen()
    }

    private(set) lazy var flipViewModels = { (0...5).map { _ in FlipViewModel() } }()

    // MARK: - Private

    private func setupTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [timeFormatter] in timeFormatter.string(from: $0) }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] in self?.setTimeInViewModels(time: $0) })
            .store(in: &cancellables)
    }
    
    private func checkIfWaitScreen() {
        Timer
            .publish(every: 1, tolerance: 1, on: .main, in: .default)
            .autoconnect()
            .ma
    }
    
    private func publishTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .default) { _ in
            self.duration -= 1
            // let seconds = Int(self.duration) % 60
            
            if self.duration <= 0 {
                self.haultTimer()
            }
        }
    }
    
    func haultTimer() {
        timer = nil
        // TODO: - SHOW SCRATCH CARD
    }

    private func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.text = "\(number)"
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private let timeFormatter = DateFormatter.timeFormatter

}

class FlipViewModel: ObservableObject, Identifiable {

    var text: String? {
        didSet { updateTexts(old: oldValue, new: text) }
    }

    @Published var newValue: String?
    @Published var oldValue: String?

    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    func updateTexts(old: String?, new: String?) {
        guard old != new else { return }
        oldValue = old
        animateTop = false
        animateBottom = false

        withAnimation(Animation.easeIn(duration: 0.2)) { [weak self] in
            self?.newValue = new
            self?.animateTop = true
        }

        withAnimation(Animation.easeOut(duration: 0.2).delay(0.2)) { [weak self] in
            self?.animateBottom = true
        }
    }

}
