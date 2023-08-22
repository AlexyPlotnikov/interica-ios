//
//  RXServerConnector.swift
//  AbieSystem
//
//  Created by RX Group on 28/12/2018.
//  Copyright © 2018 RX Group. All rights reserved.
//

import Foundation
import UIKit

var movieData = [String: Any]()
var domain = "https://ssr-api.abiesys.ru"




func postLoginRequest(URLString:String,body:String, completion:@escaping (_ array: [String:Any])->Void) {
 
    let myURL = NSURL(string: URLString)!
    let request = NSMutableURLRequest(url: myURL as URL)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = body.data(using: .utf8)
       
      
       let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
           
           guard let data = data else { return }
           do {
               movieData  =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
               completion(movieData)
           } catch let error as NSError {
               
               print(error)
           }
       })
       
       task.resume()

}

func getPatchRequest(URLString:String, completion:@escaping (Dictionary<String, Any>)->Void) {
   
    var request = URLRequest(url: NSURL(string: URLString)! as URL)
    if Auth.sharedInstance().tokenExist {
        request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
    }
    request.httpMethod = "PATCH"
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
        guard let data = data else { return }
        do {
            
            movieData  =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            completion(movieData)
            
        } catch let error as NSError {
            print(error)
        }
    })
    
    task.resume()
    
}


func getRequest(URLString:String, needSecretKey:Bool = false, completion:@escaping (Dictionary<String, Any>)->Void) {
        print(URLString)
        var request = URLRequest(url: NSURL(string: URLString)! as URL)
            request.httpMethod = "GET"
        if Auth.sharedInstance().tokenExist {
            request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
        }
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
           
            guard let data = data else { return }
          
            if let movieData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
              
                        completion(movieData)
            }else{
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 404){
                        completion(["error":"404"])
                    }
                }
                completion(["error":"401"])
            }
                
            
        })
        
        task.resume()
   
}

func deleteRequest(URLString:String, completion:@escaping (Dictionary<String, Any>)->Void) {
        print(URLString)
        var request = URLRequest(url: NSURL(string: URLString)! as URL)
        if Auth.sharedInstance().tokenExist {
            request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
        }
    
        request.httpMethod = "DELETE"
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 300.0
        sessionConfig.timeoutIntervalForResource = 600.0
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
           
            guard let data = data else { return }
          
            if let movieData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
              
                        completion(movieData)
            }else{
                completion(["error":"401"])
            }
                
            
        })
        
        task.resume()
}

func getArrayRequest(URLString:String, needSecretKey:Bool = false, completion:@escaping (_ array: NSArray)->Void) {
 
    print(URLString)
    var request = URLRequest(url: NSURL(string: URLString)! as URL)
        request.httpMethod = "GET"
    if Auth.sharedInstance().tokenExist {
        request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
    }

    let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
         guard let data = data else { return }
           do {
            if let GETdata  =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray{
                completion(GETdata)
            }else{
                completion([])
            }
           
             
           } catch  {
            print(error.localizedDescription)
           completion([])
       }
    })
    
    task.resume()
   
}



func postReq(URLString:String, completion:@escaping (Dictionary<String, Any>)->Void) {
    
    var request = URLRequest(url: NSURL(string: URLString)! as URL)
    if Auth.sharedInstance().tokenExist {
        request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
    }
        request.httpMethod = "POST"
    
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
        
        guard let data = data else { return }
        do {
            movieData  =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            
            completion(movieData)
            
            
        } catch let error as NSError {
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 401){
                    
                    completion(["error":"401"])
                }
            }
            print(error)
        }
    })
    
    task.resume()
    
}

func postRequest(JSON:[String: Any], URLString:String, needSecretKey:Bool = false, completion:@escaping (Dictionary<String, Any>)->Void) {
    print(URLString)
    var request = URLRequest(url: NSURL(string: URLString)! as URL)
    if Auth.sharedInstance().tokenExist {
        request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
    }
  
    request.httpMethod = "POST"
  
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
        
 
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
   
    let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
        
        guard let data = data else {
            
            return
        }
        do {
           
            if let GETdata  =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                print("1")
                 completion(GETdata)
            }
        } catch {
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 200){
                    completion(["token":String(data: data, encoding: String.Encoding.utf8) ?? ""])
                    
                }
            }
        }
        
    })
    
    task.resume()
}
func postPaymentRequest(JSON:String,needAuth:Bool = false, URLString:String, completion:@escaping (Dictionary<String, Any>)->Void) {
    
    var request = URLRequest(url: NSURL(string: URLString)! as URL)
   
    if Auth.sharedInstance().tokenExist {
        request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
    }
    request.httpMethod = "POST"
    request.httpBody = JSON.data(using: .utf8)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
  
    let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
        
        guard let data = data else {
            
            return
        }
     
            if let GETdata  =  try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                completion(GETdata)
            }else{
                if let GETdata  =  try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? String {
                    completion(["id":GETdata])
                }else{
                    let contents = String(data: data, encoding: .ascii)
                    completion(["html":contents!])
                }
               
                
            }
//        } catch {
//            if let httpResponse = response as? HTTPURLResponse {
//                if(httpResponse.statusCode == 200){
//                     let theJSONData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                       print(theJSONData)
//
//                    completion([:])
//                }
//            }
//        }
        
    })
    
    task.resume()
    
}


func putRequest(JSON:[String: Any], URLString:String, completion:@escaping (Dictionary<String, Any>)->Void){
    
    var request = URLRequest(url: NSURL(string: URLString)! as URL)
    if Auth.sharedInstance().tokenExist {
        request.addValue("Bearer \(Auth.sharedInstance().getToken())", forHTTPHeaderField: "Authorization")
    }
    request.httpMethod = "PUT"
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
        
        guard let data = data else { return }
        do {
            movieData  =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            completion(movieData)
        } catch let error as NSError {
            
            print(error)
        }
    })
    
    task.resume()
   
}



func createBodyWithParameters(filePathKey: String?, imageDataKey: NSData, boundary: String, filename: String) -> NSData {
    let body = NSMutableData();
    let mimetype = "image/jpg"
    
    body.appendString(string: "--\(boundary)\r\n")
    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey as Data)
    body.appendString(string: "\r\n")
    
    
    
    body.appendString(string: "--\(boundary)--\r\n")
    
    return body
}



func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}


fileprivate extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(obj: Element) {
        if let index = firstIndex(of: obj) {
            remove(at: index)
        }
    }
}
