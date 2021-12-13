//
//  AuthViewModel.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import FirebaseAuth
import Combine
import FirebaseFirestoreSwift
import SwiftUI
import GoogleSignIn
import Firebase

final class AuthenticationViewModel: ObservableObject {
    
    @Published var state: AuthState
    private var authenticator: GoogleSignInAuthenticator {
        return GoogleSignInAuthenticator(authViewModel: self)
    }
    
    
    init() {
        if let user = Auth.auth().currentUser {
            self.state = .signedIn(user)
        } else {
            self.state = .signedOut
        }
    }
    
    
    func signIn() {
        authenticator.signIn()
    }
    
    
    func signOut() {
        authenticator.signOut()
    }
    
    
    func disconnect() {
        authenticator.disconnect()
    }
    
    func checkAuthStatus() {
        authenticator.checkAuthStatus()
    }
}

extension AuthenticationViewModel {
    
    enum AuthState {
        case signedIn(User)
        case signedOut
    }
}
