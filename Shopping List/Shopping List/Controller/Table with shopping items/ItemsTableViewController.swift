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

            if shoppingModel.add(item) {
                let newIndexPath = IndexPath(row: shoppingModel.shoppingList.count - 1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                os_log("Item was successfully added.", log: OSLog.default, type: .debug)
            } else {
                os_log("Maximum capacity of the ShoppingList is 10 items", log: OSLog.default, type: .debug)
            }
        }
    }

    // According to limitation of the free version, prevent segue when trying to add extra item to the list.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "AddItem", shoppingModel.shoppingList.count < shoppingModel.maximumNumberOfItems else {
            let alert = UIAlertController(title: "Free version limitation",
                                          message: """
                                                Buy the full version of our application to unlock additional features.
                                                Like adding more than 10 items to the list.
                                                """,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return false
        }
        return true
    }

}
