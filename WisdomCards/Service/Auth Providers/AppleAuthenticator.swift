//
//  AppleAuthenticator.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
import GoogleSignIn
import CryptoKit
import AuthenticationServices

/// An observable class for authenticating via Apple.
final class AppleSignInAuthenticator: NSObject, ObservableObject {
    
    
    private var authViewModel: AuthenticationViewModel
    private var currentNonce: String?
    
    /// Creates an instance of this authenticator.
    /// - parameter authViewModel: The view model this authenticator will set logged in status on.
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    
    /// Signs in the user based upon the selected account.'
    /// - note: Successful calls to this will set the `authViewModel`'s `state` property.
    func signIn() {
        let nonce = String.randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce.sha256
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    
    
}


extension AppleSignInAuthenticator: AuthenticationService {
    
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


// MARK: - APPLE SIGN IN
extension AppleSignInAuthenticator: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows[0]
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                // BFLogErr("\(#function): Invalid state: A login callback was received, but no login request was sent.")
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print(">>> \(#function): Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print(">>> \(#function): Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            proceedThroughFirebase(credential: credential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(">>> \(#function): Sign in with Apple error: \(error)")
        // self.showAlert(message: error.localizedDescription)
    }
    

    
}
