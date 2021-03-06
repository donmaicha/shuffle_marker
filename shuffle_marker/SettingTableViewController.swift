//
//  SettingTableViewController.swift
//  shuffle_marker
//
//  Created by donmaicha on 2020/03/01.
//  Copyright © 2020 donmaicha. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var timeTextBox: UITextField!
    
    var alertVisibllty:Bool = UserDefaults.standard.bool(forKey: "alertVisibllty")
    @IBOutlet weak var AlertVisibleSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeTextBox.keyboardType = UIKeyboardType.numberPad
        
        alertVisibllty = UserDefaults.standard.bool(forKey: "alertVisibllty")
        AlertVisibleSwitch.setOn(alertVisibllty, animated: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var ret: Int = 0
        
        switch section {
        case 0:
            ret = 2
        default:
            ret = 0
        }
        return ret
    }

    @IBAction func ChangeAlertVisibllty(_ sender: Any) {
        let isOnShowSwitch:Bool = (sender as AnyObject).isOn
        UserDefaults.standard.set(isOnShowSwitch, forKey: "alertVisibllty")
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
