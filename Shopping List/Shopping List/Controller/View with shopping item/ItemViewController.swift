//
//  ItemViewController.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/2/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

import UIKit
import os.log

class ItemViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Propeties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     This value is either passed by `ItemsTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new item.
     */
    var item: String?

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Enable the Save button only if the text field has a valid Item name.
        updateSaveButtonState()

        // Set up views if editing an existing Meal.
        if let item = item {
            navigationItem.title = item
            nameTextField.text   = item
        }

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation),
        // this view controller needs to be dismissed in two different ways.
        let isPresentingInAddItemMode = presentingViewController is UINavigationController

        if isPresentingInAddItemMode {
            dismiss(animated: true, completion: nil)
            os_log("Cancel adding a new item.", log: OSLog.default, type: .debug)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
            os_log("Cancel editing current item.", log: OSLog.default, type: .debug)
        } else {
            fatalError("The ItemViewController is not inside a navigation controller.")
        }
    }

    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: sender)

        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        item = nameTextField.text ?? ""
    }

    // MARK: - Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
