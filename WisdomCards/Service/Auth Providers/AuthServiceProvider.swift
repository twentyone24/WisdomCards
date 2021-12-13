//
//  AuthServiceProvider.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

protocol AuthenticationService {
    func setUserAndProceedLogin(user: User) -> Void
    func signIn()
    // func signOut()
}

class AuthProvider {
    
    static let shared = AuthProvider()
    
    private init() {
        // auth.addStateDidChangeListener(authStateChanged)
    }
    
    private let auth = Auth.auth()
    var firebaseUID: String? {
        auth.currentUser?.uid
    }
}
