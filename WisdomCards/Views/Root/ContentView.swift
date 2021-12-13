//
//  ContentView.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/11/21.
//

import SwiftUI
import CoreData
import AVFoundation
import GoogleSignIn

struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    init() {
        setMixWithOthersPlaybackCategory()
    }
    
    @ViewBuilder
    var body: some View {
        
        switch authViewModel.state {
            case .signedIn:
                HomeView()
            case .signedOut:
                AuthView()
        }
            
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension ContentView {
    
    private func setMixWithOthersPlaybackCategory() {
        try? AVAudioSession.sharedInstance().setCategory(
            AVAudioSession.Category.ambient,
            mode: AVAudioSession.Mode.moviePlayback,
            options: [.mixWithOthers])
    }
    
}
