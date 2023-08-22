//
//  Extensions.swift
//  TZB
//
//  Created by RX Group on 27.07.2022.
//

import Foundation
import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func format(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}




extension UITextField{
    func addToolBar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction(){
            self.resignFirstResponder()
    }
}

extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}


extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}


extension UIViewController{
    
    func setTap(){
        let tapGestureRecognizer = UITapGestureRecognizer()
            tapGestureRecognizer.addTarget(self, action: #selector(handleTap))
            tapGestureRecognizer.cancelsTouchesInView=false
            self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }
    
    func setMessage(_ text:String, rootVC:UIViewController) {
        DispatchQueue.main.async{
            let alertController = UIAlertController(title: "Внимание!", message:
                text , preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            rootVC.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UITextView{
    func addToolBar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction(){
            self.resignFirstResponder()
    }
}
