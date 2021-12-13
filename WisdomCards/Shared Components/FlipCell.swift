//
//  FlipCell.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import SwiftUI

struct FlipCell: View {
    
    init(text: String, type: FlipType) {
        self.text = text
        self.type = type
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 40))
            .fontWeight(.heavy)
            .foregroundColor(.textColor)
            .fixedSize()
            .padding(type.padding, -20)
            .frame(width: 15, height: 20, alignment: type.alignment)
            .padding(type.paddingEdges, 10)
            .clipped()
            .background(Color.flipBackground)
            .cornerRadius(4)
            .padding(type.padding, -4.5)
            .clipped()
    }
    
    enum FlipType {
        case top
        case bottom
        
        var padding: Edge.Set {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }
        
        var paddingEdges: Edge.Set {
            switch self {
            case .top:
                return [.top, .leading, .trailing]
            case .bottom:
                return [.bottom, .leading, .trailing]
            }
        }
        
        var alignment: Alignment {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }
        
    }
    
    // MARK: - Private
    
    private let text: String
    private let type: FlipType
    
}

struct FlipCell_Previews: PreviewProvider {
    static var previews: some View {
        FlipCell(text: "1", type: .bottom)
    }
}

