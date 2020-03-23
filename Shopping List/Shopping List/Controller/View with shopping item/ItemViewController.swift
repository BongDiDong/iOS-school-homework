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

    var item: String?

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self

        nameTextField.becomeFirstResponder()
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = textField.text
    }

    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        os_log("Cancel adding a new item.", log: OSLog.default, type: .debug)
    }

    // Prevent segue when trying to save an empty item.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let button = sender as? UIBarButtonItem,
               button === saveButton,
               nameTextField.text == "" {

            let alert = UIAlertController(title: "Empty item name",
                                          message: "Enter the item name before saving it.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return false
        }
        return true
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
}