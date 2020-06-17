//
//  CoreDataList.swift
//  Shopping List
//
//  Created by Андрей Погосский on 6/16/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

import Foundation
import CoreData
import os.log

class CoreDataManager {

    private enum Entities {
        static let item = "Item"
    }

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingList")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                os_log("Unable to load persistent store.", log: OSLog.default, type: .debug)
            }
        }

        return container
    }()

    private init() { }

    func addItem(with name: String) {
        let context = persistentContainer.viewContext
        let item = Item(context: context)

        item.name = name

        do {
            try context.save()
        } catch {
            os_log("Failed to save item.", log: OSLog.default, type: .debug)
        }
    }

    func getItems() -> [Item] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Item>(entityName: Entities.item)

        do {
            let items = try context.fetch(fetchRequest)
            return items
        } catch {
            os_log("Failed to get items.", log: OSLog.default, type: .debug)
            return []
        }
    }

    func removeItem(at index: Int) {
        let context = persistentContainer.viewContext
        let items = getItems()

        context.delete(items[index])

        do {
            try context.save()
        } catch {
            os_log("Failed to delete item.", log: OSLog.default, type: .debug)
        }
    }
}
