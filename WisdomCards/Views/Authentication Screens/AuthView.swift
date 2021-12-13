//
//  AuthView.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @ViewBuilder
    var body: some View {
        
        Button {
            authViewModel.signIn()
        } label: {
            Text("GOOGLE SIGN IN")
        }

    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
