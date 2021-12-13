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
    
    @Published var state: State
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
    
    /// Signs the user in.
    func signIn() {
        authenticator.signIn()
    }
    
    /// Signs the user out.
    func signOut() {
        authenticator.signOut()
    }
    
    /// Disconnects the previously granted scope and logs the user out.
    func disconnect() {
        authenticator.disconnect()
    }
    
    func checkAuthStatus() {
        authenticator.checkAuthStatus()
    }
}

extension AuthenticationViewModel {
    /// An enumeration representing logged in status.
    ///
    enum State {
        case signedIn(User)
        case signedOut
    }
}
