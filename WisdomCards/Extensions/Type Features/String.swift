//
//  String.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import CryptoKit

// MARK: - STRING EXTENSIONS
extension String: Identifiable {
    
    public var id: String {
        self
    }
    
    var data: Data { .init(utf8) }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print(error)
            return nil
        }
    }
    
    var html2String: String { html2AttributedString?.string ?? "" }
    
    var unicodes: [UInt32] { unicodeScalars.map(\.value) }
    
    var sha256: String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    func generateRandom(size: UInt = 5) -> String {
        let prefixSize = Int(min(size, 43))
        let uuidString = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        return String(Data(uuidString.utf8)
                        .base64EncodedString()
                        .replacingOccurrences(of: "=", with: "")
                        .prefix(prefixSize))
    }
    
    var isEmptyOrWhitespace: Bool {
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
    
    var isValid: Bool {
        if self.isEmpty || self == "" || self == "." || self.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
    /// Check if the name is valid
    /// - Returns: Bool
    var isValidName: Bool {
        //            let regex1 = "([A-Za-z](\\s)){3,15}"
        let regex = "^[a-zA-Z].*[\\s\\.]*$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
    
    /// Check if the password is valid: [8...16] with 1 alphabet & 1 special Character
    /// - Returns: Bool
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    /// Check if the url is valid
    /// - Returns: Bool
    var isValidUrl: Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: self)
        return result
    }
    
    /// Check if the username is valid: [6...16] with 1 alphabet & 1 special Character
    /// - Returns: Bool
    var isValidUsername: Bool {
        let RegEx = "[a-z0-9\\-\\.]{3,15}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
    var validateUsername: String? {
        
        if self.isEmptyOrWhitespace { return "Username cannot be empty." }
        if self.count < 3 { return "Username should at least be 3 characters." }
        if self.count > 15 { return "Username cannot be more than 15 characters long." }
        if self.contains(find: " ") { return "Username cannot contain whitespace." }
        if self.first == "_" { return "Username should not start with underscore(_)."}
        if self.isNumber { return "Username cannot have only numbers." }
        
        if !NSPredicate(format:"SELF MATCHES %@", "[a-zA-Z0-9\\_\\-\\.]{3,15}").evaluate(with: self) { return "Please enter a valid username." }
        
        return nil
    }
    
    var validateName: String? {
        
        if self.isEmptyOrWhitespace { return "Name cannot be empty." }
        if self.count < 3 { return "Name should at least be 3 characters." }
        if self.count > 20 { return "Name cannot be more than 20 characters long." }
        
        if self.isNumber { return "Name cannot have only numbers." }
        
        if !NSPredicate(format:"SELF MATCHES %@", "^[a-zA-Z].*[\\s\\.]*$").evaluate(with: self) {
            return "Name cannot have special characters or numbers."
        }
        
        if !NSPredicate(format:"SELF MATCHES %@", "^[a-zA-Z].*[\\s\\.]*$").evaluate(with: self) { return "Please enter a valid name" }
        
        return nil
    }
    
    var isNumber: Bool {
        // !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        Double(self) != nil
    }
    
    func getDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func getDay() -> String {
        let date = self.components(separatedBy: "T")
        return date[0]
    }
    
    var formattedText: String {
        self.replacingOccurrences(of: "_", with: " ")
    }
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
    
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
    
    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }
    
    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }
    
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
    
    func trim() -> String {
        self.trimmingCharacters(in: .whitespaces)
    }
    
}
