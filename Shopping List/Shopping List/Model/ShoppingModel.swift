//
//  ShoppingModel.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/2/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

class ShoppingModel: ShoppingList {
    private(set) var shoppingList = CoreDataManager.shared.getItems()

    let maximumNumberOfItems = 10

    func add(_ item: String) -> Bool {
        guard shoppingList.count < 10,
              let newItem = CoreDataManager.shared.addItem(with: item)
        else { return false }

        shoppingList.append(newItem)
        return true
    }

    func remove(at index: Int) -> Bool {
        guard (0..<shoppingList.count).contains(index) else { return false }

        let removedItem = shoppingList.remove(at: index)
        CoreDataManager.shared.removeItem(item: removedItem)
        return true
    }
}
