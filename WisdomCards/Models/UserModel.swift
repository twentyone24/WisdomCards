//
//  userData.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel:  Identifiable, Codable {
    @DocumentID var id: String?
    var fullName: String
    var email: String
    
    var passed: Bool = false
}
