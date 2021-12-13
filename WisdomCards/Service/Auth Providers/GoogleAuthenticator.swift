//
//  GoogleAuthenticator.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth
import SwiftUI
import CryptoKit
import AuthenticationServices

/// An observable class for authenticating via Google.
final class GoogleSignInAuthenticator: ObservableObject {
    
    private let clientID = AppSecrets.GoogleClientID
    
    private lazy var configuration: GIDConfiguration = {
        return GIDConfiguration(clientID: clientID)
    }()
    
    private var authViewModel: AuthenticationViewModel
    
    /// Creates an instance of this authenticator.
    /// - parameter authViewModel: The view model this authenticator will set logged in status on.
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    
    /// Signs in the user based upon the selected account.'
    /// - note: Successful calls to this will set the `authViewModel`'s `state` property.
    func signIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print(">>> There is no root view controller!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(
            with: configuration,
            presenting: rootViewController
        ) { [weak self] user, error in
            
            guard let user = user else {
                print(">>> Error! \(String(describing: error))")
                return
            }
          

            let credential = GoogleAuthProvider.credential(
                withIDToken: user.authentication.idToken ?? "",
                accessToken: user.authentication.accessToken)
            
            self?.proceedThroughFirebase(credential: credential)
        }
    }
    
    /// Signs out the current user.
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        try? Auth.auth().signOut()
        authViewModel.state = .signedOut
    }
    
    
    /// Disconnects the previously granted scope and signs the user out.
    func disconnect() {
        GIDSignIn.sharedInstance.disconnect { error in
            if let error = error {
                print("Encountered error disconnecting scope: \(error).")
            }
            self.signOut()
        }
    }
    
    func checkAuthStatus() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            if let user = user {
                
                let credential = GoogleAuthProvider.credential(
                    withIDToken: user.authentication.idToken ?? "",
                    accessToken: user.authentication.accessToken)
                self.proceedThroughFirebase(credential: credential)
                
            } else if let error = error {
                self.authViewModel.state = .signedOut
                print("There was an error restoring the previous sign-in: \(error)")
            } else {
                self.authViewModel.state = .signedOut
            }
        }
    }
    
}


extension GoogleSignInAuthenticator: AuthenticationService {
    
    func proceedThroughFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                // self.showAlert(message: error.localizedDescription)
                print(">>> Error! \(String(describing: error))")
                return
            }
            
            if let user = authResult?.user {
                self.setUserAndProceedLogin(user: user)
            } else if let error = error {
                print(#function, "Sign in with Google error: \(error)")
                // self.showAlert(message: error.localizedDescription)
            }
            
        }
    }
    
    func setUserAndProceedLogin(user: User) -> Void {
        self.authViewModel.state = .signedIn(user)
    }
}

