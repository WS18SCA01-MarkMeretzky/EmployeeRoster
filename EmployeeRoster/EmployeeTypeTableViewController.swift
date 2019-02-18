//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Mark Meretzky on 2/18/19.
//

import UIKit;

protocol EmployeeTypeDelegate {                 //p. 724, step 3, bullet 1
    func didSelect(employeeType: EmployeeType); //p. 725, step 3, bullet 2
}

class EmployeeTypeTableViewController: UITableViewController {   //p. 723, step 2, bullet 4
    
    var delegate: EmployeeTypeDelegate? = nil; //p. 725, step 3, bullet 3
    var employeeType: EmployeeType? = nil;     //p. 723, step 2, bullet 5

    override func viewDidLoad() {
        super.viewDidLoad();

        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // navigationItem.rightBarButtonItem = editButtonItem;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeType.all.count;   //p. 723, step 2, bullet 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //p. 723, step 2, bullet 7
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeCell", for: indexPath);

        // Configure the cell...
        let type: EmployeeType = EmployeeType.all[indexPath.row];
        cell.textLabel?.text = type.description();
        cell.accessoryType = employeeType == type ? .checkmark : .none;
        return cell;
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true;
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        return true;
    }
    */
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //page 724, step 2, bullet 8
        tableView.deselectRow(at: indexPath, animated: false);
        employeeType = EmployeeType.all[indexPath.row];
        delegate?.didSelect(employeeType: employeeType!);   //p. 725, step 3, bullet 4
        tableView.reloadData();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
