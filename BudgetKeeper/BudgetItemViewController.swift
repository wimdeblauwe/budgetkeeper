//
//  BudgetItemViewController.swift
//  BudgetKeeper
//
//  Created by Wim Deblauwe on 02/05/16.
//  Copyright © 2016 Wim Deblauwe. All rights reserved.
//

import UIKit

class BudgetItemViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var budgetItem:BudgetItem?
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        let isPresentingInAddItemMode = presentingViewController is UINavigationController
        
        if isPresentingInAddItemMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( saveButton === sender ) {
            budgetItem = BudgetItem(name: descriptionTextField.text!, price: Int(priceTextField.text!)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextField.delegate = self
        priceTextField.delegate = self
        
        if let budgetItem = budgetItem {
            navigationItem.title = budgetItem.name
            descriptionTextField.text = budgetItem.name
            priceTextField.text = String(budgetItem.price)
        }
        
        updateSaveButtonStatus()
        
        descriptionTextField.addTarget(self, action: #selector(BudgetItemViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        priceTextField.addTarget(self, action: #selector(BudgetItemViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        descriptionTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    
    func textFieldDidChange(textField: UITextField) {
        updateSaveButtonStatus();
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        updateSaveButtonStatus()
    }
    
    func updateSaveButtonStatus() {
        saveButton.enabled = hasText(descriptionTextField) && hasText(priceTextField)
    }
    
    func hasText(textField:UITextField)->Bool {
        if let text = textField.text {
            return !text.isEmpty
        }
        else {
            return false;
        }
    }

}

