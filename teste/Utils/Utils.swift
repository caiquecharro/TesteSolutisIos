//
//  Utils.swift
//  teste
//
//  Created by caique charro on 18/08/21.
//

import Foundation


class Utils{
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool{
        
        if !hasEspecialCharacters(string: password){
            
            return false
            
        } else if !hasLowercaseCharacters(string: password){
            
            return false
            
        }else if !hasNumberCharacters(string: password){
            
            return false
            
        }
        //        else if !hasUppercaseCharacters(string: password){
        //
        //            return false
        //
        //        }
        return true
        
    }
    
    func hasUppercaseCharacters(string: String) -> Bool {
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let textCheck = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalResult = textCheck.evaluate(with: string)

        return capitalResult
        
    }
    func hasLowercaseCharacters(string: String) -> Bool {
        
        let lowerLetterRegEx  = ".*[a-z]+.*"
        let textCheck = NSPredicate(format:"SELF MATCHES %@", lowerLetterRegEx)
        let lowerResult = textCheck.evaluate(with: string)

        return lowerResult
        
    }
    
    func hasNumberCharacters(string: String) -> Bool {
        
        let numberRegEx  = ".*[0-9]+.*"
        let textCheck = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberResult = textCheck.evaluate(with: string)


        return numberResult
        
    }
    
    func hasEspecialCharacters(string: String) -> Bool {
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let textCheck = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let specialResult = textCheck.evaluate(with: string)

        return specialResult
        
    }
    
    
    
    
}
