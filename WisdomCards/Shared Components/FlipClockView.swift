//
//  FlipClockView.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import SwiftUI

struct FlipClockView: View {
    
    let viewModel = ClockViewModel()
    
    var body: some View {
        HStack(spacing: 15) {
            HStack(spacing: 5) {
                FlipContainer(viewModel: viewModel.flipViewModels[0])
                FlipContainer(viewModel: viewModel.flipViewModels[1])
            }
            HStack(spacing: 5) {
                FlipContainer(viewModel: viewModel.flipViewModels[2])
                FlipContainer(viewModel: viewModel.flipViewModels[3])
            }
            HStack(spacing: 5) {
                FlipContainer(viewModel: viewModel.flipViewModels[4])
                FlipContainer(viewModel: viewModel.flipViewModels[5])
            }
        }
    }
    
}

struct FlipClockView_Previews: PreviewProvider {
    static var previews: some View {
        FlipClockView()
    }
}
