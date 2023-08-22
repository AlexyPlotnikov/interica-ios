//
//  TextViewController.swift
//  Interica
//
//  Created by RX Group on 25.10.2022.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var placeholder = "Опишите планируемый бюджет на комплектацию интерьера"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        
        self.setTap()
        textView.addToolBar()
    }
    

   

}

extension TextViewController:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {

            if !textView.text!.isEmpty && textView.text! == placeholder {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
        
            if textView.text.isEmpty {
                textView.text = placeholder
                textView.textColor = UIColor.lightGray
            }
        }
}
