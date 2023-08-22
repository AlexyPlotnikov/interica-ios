//
//  RadioController.swift
//  Interica
//
//  Created by Алексей on 18.10.2022.
//

import UIKit

class RadioController: UIViewController {
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension RadioController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "radioCell"
        let cell = self.table.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RadioCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioCell {
            cell.radioImage.image = UIImage(named: "radioDisable")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioCell {
            cell.radioImage.image = UIImage(named: "radioActive")

        }
    }


}
