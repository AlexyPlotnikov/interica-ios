//
//  CheckboxController.swift
//  Interica
//
//  Created by RX Group on 24.10.2022.
//

import UIKit

class CheckboxController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension CheckboxController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "checkboxCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CheckboxCell
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CheckboxCell{
            cell.select = !cell.select
            if(cell.select){
                cell.checkImage.image = UIImage(named: "checkboxActive")
            }else{
                cell.checkImage.image = UIImage(named: "checkboxDisable")
            }
           

        }
    }
    
    
}
