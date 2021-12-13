//
//  HomeView.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Text("SIGNED IN")
            Button(action: authViewModel.signOut, label: {
                Text("LOG OUT")
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthenticationViewModel())
    }
}
