//
//  ItemsTableViewController.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/2/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

import UIKit
import os.log

class ItemsTableViewController: UITableViewController {

    // MARK: - Properties
    let shoppingModel = ShoppingModel()

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Actions
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ItemViewController, let item = sourceViewController.item {

            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                if shoppingModel.edit(at: selectedIndexPath.row, with: item) {
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                    os_log("Item was successfully edited.", log: OSLog.default, type: .debug)
                } else {
                    os_log("Something goes wrong while editing the item.", log: OSLog.default, type: .debug)
                }
            } else {
                // Add a new item.
                if shoppingModel.add(item) {
                    let newIndexPath = IndexPath(row: shoppingModel.shoppingList.count - 1, section: 0)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                    os_log("Item was successfully added.", log: OSLog.default, type: .debug)
                } else {
                    os_log("Maximum capacity of the ShoppingList is 10 items", log: OSLog.default, type: .debug)
                }
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        let alert = UIAlertController(title: "Oops",
                                      message: "Sorry, something goes wrong. Restart the app if it's possible",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("Adding a new item.", log: OSLog.default, type: .debug)

        case "ShowDetail":
            guard let itemDetailViewController = segue.destination as? ItemViewController else {
                os_log("Segue destination is not ItemViewController. Segue Identifier 'ShowDetail'.",
                       log: OSLog.default, type: .error)
                self.present(alert, animated: true, completion: nil)
                return
            }

            guard let selectedItemCell = sender as? ItemTableViewCell else {
                os_log("Selected cell is not ItemTableViewCell. Segue Identifier 'ShowDetail'.",
                       log: OSLog.default, type: .error)
                self.present(alert, animated: true, completion: nil)
                return
            }

            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                os_log("Index path for cell is invalid. Segue Identifier 'ShowDetail'.",
                       log: OSLog.default, type: .error)
                self.present(alert, animated: true, completion: nil)
                return
            }

            let selectedItem = shoppingModel.shoppingList[indexPath.row]
            itemDetailViewController.item = selectedItem

        default:
            os_log("Unexpected Segue Identifier.", log: OSLog.default, type: .error)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
