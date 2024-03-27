//
//  PasswordCriterial.swift
//  Password-Components
//
//  Created by Baran Baran on 26.03.2024.
//

import Foundation


struct PasswordCriteria {
    // Bu fonksiyon, şifrenin 8 ile 32 karakter arasında olup olmadığını kontrol eder.
    static func lengthCriteriaMet(_ text: String) -> Bool {
        return text.count >= 8 && text.count <= 32
    }

    // Bu fonksiyon, şifrede boşluk olup olmadığını kontrol eder.
    static func noSpaceCriteriaMet(_ text: String) -> Bool {
        return text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }

    // Bu fonksiyon, uzunluk ve boşluk kriterlerinin ikisini de kontrol eder ve her ikisi de sağlanıyorsa true döner.
    static func lengthAndNoSpaceMet(_ text: String) -> Bool {
        return lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }

    // Bu fonksiyon, şifrede en az bir büyük harf olup olmadığını kontrol eder.
    static func uppercaseMet(_ text: String) -> Bool {
        return text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }

    // Bu fonksiyon, şifrede en az bir küçük harf olup olmadığını kontrol eder.
    static func lowercaseMet(_ text: String) -> Bool {
        return text.range(of: "[a-z]+", options: .regularExpression) != nil
    }

    // Bu fonksiyon, şifrede en az bir rakam olup olmadığını kontrol eder.
    static func digitMet(_ text: String) -> Bool {
        return text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    
    static func specialCharacterMet(_ text: String) -> Bool {
        // regex escaped @:?!()$#,.\/
        return text.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil
    }
}

