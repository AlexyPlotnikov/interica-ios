//
//  LoginController.swift
//  Interica
//
//  Created by Алексей on 18.10.2022.
//

import UIKit
import SPIndicator

class LoginController: UIViewController {
    @IBOutlet weak var loginField: LoginTextField!
    var userPhone = ""
    var code = ""
    var stepIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTap()
        
    }
    

    @IBAction func enterPhone(_ sender: Any) {
        if(stepIndex == 0){
            if(userPhone.count == 17){
                userPhone = userPhone.replacingCharacters(in: ...userPhone.startIndex, with: "7")
               
                userPhone = userPhone.replacingOccurrences(of: " ", with: "")
                userPhone = userPhone.replacingOccurrences(of: "(", with: "")
                userPhone = userPhone.replacingOccurrences(of: ")", with: "")
                userPhone = userPhone.replacingOccurrences(of: "-", with: "")
            
              
                if(!Auth.sharedInstance().isAuth){
                    self.resendCode()
                }else{
                    Auth.sharedInstance().checkPhone(phone: userPhone, tokenReady: {(token, ready) in
                        if(!ready){
                            DispatchQueue.main.async {
                                self.setMessage(token!, rootVC: self)
                            }
                        }
                    })
                }
                self.stepIndex = 1
                self.loginField.text = ""
                self.loginField.placeholder = "Код"
            }else{
                self.setMessage("Номер телефона заполнен не полностью", rootVC: self)
            }
        }else{
            if(!Auth.sharedInstance().isAuth){
                if((self.loginField.text ?? "") == code){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "welcomeVC")
                    initialViewController.modalPresentationStyle = .fullScreen
                    self.present(initialViewController, animated: true)
                }
            }else{
                Auth.sharedInstance().verifyPhone(phone: userPhone, code: self.loginField.text ?? "", tokenReady: {
                    (token, ready) in
                    if(ready){
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let initialViewController = storyboard.instantiateViewController(withIdentifier: "welcomeVC")
                            initialViewController.modalPresentationStyle = .fullScreen
                            self.present(initialViewController, animated: true)
                        }
                       
                    }else{
                        self.setMessage("Код введен не правильно", rootVC: self)
                    }
                })
            }
        }
    }
    
    @objc func resendCode(){
        code = "\(self.random(digits: 4))"
        let indicatorView = SPIndicatorView(title: "Код для входа \(code)", preset: .done)
        indicatorView.present(duration: 5)
       
    }
    
    func random(digits:Int) -> Int {
        let min = Int(pow(Double(10), Double(digits-1))) - 1
        let max = Int(pow(Double(10), Double(digits))) - 1
        return Int.random(in: min...max)
    }
}

extension LoginController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        var updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if(stepIndex==0){
            if(updatedText.count <= 17){
                if(updatedText.hasPrefix("7")){
                    updatedText = "8"
                }
                if(!updatedText.hasPrefix("8")){
                    updatedText = "8" + updatedText
                }
                
                userPhone = updatedText
                textField.text = userPhone.format(with: "X (XXX) XXX-XX-XX")
            }
            
            return false
        }
        
        return true
       
    }
}
