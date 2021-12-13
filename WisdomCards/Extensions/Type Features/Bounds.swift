//
//  Bounds.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import UIKit
import SwiftUI

struct bounds {
    static var width: CGFloat { UIScreen.main.bounds.width }
    static var height: CGFloat { UIScreen.main.bounds.height }
    
}


struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
    
    static var topSafeArea: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.topSafeArea ?? EdgeInsets()
    }
    
    static var bottomSafeArea: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.bottomSafeArea ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
    
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: 0, bottom: 0, trailing: 0)
    }
    
    var topSafeArea: EdgeInsets {
        EdgeInsets(top: top, leading: 0, bottom: 0, trailing: 0)
    }
    
    var bottomSafeArea: EdgeInsets {
        EdgeInsets(top: 0, leading: 0, bottom: bottom, trailing: 0)
    }
    
}
