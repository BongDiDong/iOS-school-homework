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

}
