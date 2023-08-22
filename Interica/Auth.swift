//
//  Auth.swift
//  MFC
//
//  Created by RX Group on 07.11.2022.
//

import Foundation



class Auth{
    private static var shared : Auth?
    var pushToken:String = ""
    var isAuth:Bool = false
   
    class func sharedInstance() -> Auth {
        guard let uwShared = shared else {
            shared = Auth()
            return shared!
        }
        return uwShared
    }
    
    func checkPhone(phone:String, tokenReady:@escaping ((String?, Bool))->Void){
        getRequest(URLString: domain + "/client/check/\(phone)/\(self.pushToken)", completion: {
            result in
            print(result)
            if(result["errorMessage"] as? String != nil){
                tokenReady((result["errorMessage"] as? String ?? "", false))
            }
            
        })
    }
    
    func verifyPhone(phone:String, code:String, tokenReady:@escaping ((String?, Bool))->Void){
        getRequest(URLString: domain + "/client/verify/\(phone)/\(code)", completion: {
            result in
            print(result)
            if(result["errorMessage"] as? String != nil){
                tokenReady((result["errorMessage"] as? String ?? "", false))
            }else{
                tokenReady((nil, true))
            }
            
        })
    }
    
    func getToken() -> String{
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    var tokenExist:Bool{
        return (UserDefaults.standard.string(forKey: "token") != nil)
    }
}
