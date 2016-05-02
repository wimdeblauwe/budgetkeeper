//
//  BudgetItemTableViewController.swift
//  BudgetKeeper
//
//  Created by Wim Deblauwe on 02/05/16.
//  Copyright © 2016 Wim Deblauwe. All rights reserved.
//

import UIKit

class BudgetItemTableViewController: UITableViewController {

    var budgetItems = [BudgetItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedItems = loadBudgetItems() {
            budgetItems += savedItems
        }
        else {
            loadSampleItems()
        }
    }

    func loadSampleItems() {
        let item1 = BudgetItem(name: "Schoenen Jules", price: 200)!
        let item2 = BudgetItem(name: "Kleedje", price: 100)!
        let item3 = BudgetItem(name: "Dokter", price: 50)!
        
        budgetItems += [item1, item2, item3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BudgetItemTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetItemTableViewCell
        let budgetItem = budgetItems[indexPath.row]

        cell.descriptionLabel.text = budgetItem.name
        cell.priceLabel.text = "€ \(budgetItem.price)"

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            budgetItems.removeAtIndex(indexPath.row)
            saveBudgetItems()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let budgetItemDetailViewController = segue.destinationViewController as! BudgetItemViewController
            if let selectedBudgetItemCell = sender as? BudgetItemTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedBudgetItemCell)!
                let selectedBudgetItem = budgetItems[indexPath.row]
                budgetItemDetailViewController.budgetItem = selectedBudgetItem
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new item")
        }
    }
    

    @IBAction func unwindToBudgetItemList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? BudgetItemViewController, budgetItem = sourceViewController.budgetItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                budgetItems[selectedIndexPath.row] = budgetItem
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                let newIndexPath = NSIndexPath(forRow: budgetItems.count, inSection: 0)
                budgetItems.append(budgetItem)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
        
        saveBudgetItems()
    }
    
    // MARK: NSCoding
    func saveBudgetItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(budgetItems, toFile: BudgetItem.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save items...")
        }
    }
    
    func loadBudgetItems() -> [BudgetItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(BudgetItem.ArchiveURL.path!) as? [BudgetItem]
    }
}
