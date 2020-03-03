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

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingModel.shoppingList.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "ItemTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? ItemTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ItemTableViewCell.")
        }

        let item = shoppingModel.shoppingList[indexPath.row]
        cell.nameLabel.text = item

        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if shoppingModel.remove(at: indexPath.row) {
                tableView.deleteRows(at: [indexPath], with: .fade)
                os_log("Item was successfully removed.", log: OSLog.default, type: .debug)
            } else {
                os_log("Something goes wrong while removing the item.", log: OSLog.default, type: .debug)
            }
        }
    }

    // MARK: - Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
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

        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("Adding a new item.", log: OSLog.default, type: .debug)

        case "ShowDetail":
            guard let itemDetailViewController = segue.destination as? ItemViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedItemCell = sender as? ItemTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }

            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            let selectedItem = shoppingModel.shoppingList[indexPath.row]
            itemDetailViewController.item = selectedItem

        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}
