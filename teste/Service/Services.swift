//
//  Services.swift
//  teste
//
//  Created by caique charro on 18/08/21.
//

import Foundation


class Services {
    
    
    
    func restLogin(username: String, password: String) {
        
        let params = ["username":username, "password":password] as Dictionary<String, String>

        var request = URLRequest(url: URL(string: "https://api.mobile.test.solutis.xyz/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })

        task.resume()
        
        
    }
    
    
    
}
