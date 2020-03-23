//
//  ItemsTableViewControllerExtension.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/8/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

import UIKit
import os.log

extension ItemsTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingModel.shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "ItemTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? ItemTableViewCell  else {
            os_log("The dequeued cell is not an instance of ItemTableViewCell.", log: OSLog.default, type: .error)
            return UITableViewCell()
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
}
