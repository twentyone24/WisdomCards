//
//  FlipContainer.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import SwiftUI

struct FlipContainer: View {
   
    init(viewModel: FlipViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: FlipViewModel

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                FlipCell(text: viewModel.newValue ?? "", type: .top)
                FlipCell(text: viewModel.oldValue ?? "", type: .top)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero),
                                      axis: (1, 0, 0),
                                      anchor: .bottom,
                                      perspective: 0.5)
            }
            
            Color.separator
                .frame(height: 1)
            
            ZStack {
                FlipCell(text: viewModel.oldValue ?? "", type: .bottom)
                FlipCell(text: viewModel.newValue ?? "", type: .bottom)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90),
                                      axis: (1, 0, 0),
                                      anchor: .top,
                                      perspective: 0.5)
            }
        }
            .fixedSize()
    }

}

struct FlipContainer_Previews: PreviewProvider {
    static var previews: some View {
        FlipContainer(viewModel: FlipViewModel())
    }
}
