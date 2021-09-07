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
//                else if !hasUppercaseCharacters(string: password){ return false }
        
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
    
    class func formatCPF(_ textoPuro: String?) -> String? {

        var textoFormatado = ""
        var lastPos = 0

        if (textoPuro?.count ?? 0) > 3 {
            textoFormatado += (textoPuro as NSString?)?.substring(with: NSRange(location: 0, length: 3)) ?? ""
            textoFormatado += "."
            lastPos = 3
        }
        if (textoPuro?.count ?? 0) > 6 {
            textoFormatado += (textoPuro as NSString?)?.substring(with: NSRange(location: 3, length: 3)) ?? ""
            textoFormatado += "."
            lastPos = 6
        }
        if (textoPuro?.count ?? 0) > 9 {
            textoFormatado += (textoPuro as NSString?)?.substring(with: NSRange(location: 6, length: 3)) ?? ""
            textoFormatado += "-"
            lastPos = 9
        }
        textoFormatado += (textoPuro as NSString?)?.substring(with: NSRange(location: lastPos, length: (textoPuro?.count ?? 0) - lastPos)) ?? ""

        return textoFormatado.description
    }
    
    class func formattedDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        
        let date = dateFormatterGet.date(from: dateString)
        
        let dataFormatadaString = dateFormatterPrint.string(from: date!)
        
        
        return dataFormatadaString
    }
    
    class func formattedValue(valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency
        
        let safeValue = valor
        let formattedValue = formatter.string(from: safeValue as NSNumber)
            
        return formattedValue!
    }
    
}
