//
//  ShoppingModel.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/2/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

class ShoppingModel: ShoppingList {
    private(set) var shoppingList = [String]()

    func add(_ item: String) -> Bool {
        guard shoppingList.count < 10 else { return false }

        shoppingList.append(item)
        return true
    }

    func remove(_ item: String) -> Bool {
        guard shoppingList.contains(item) else { return false }

        shoppingList.removeAll { $0 == item }
        return true
    }

    func remove(at index: Int) -> Bool {
        guard index < shoppingList.count, index >= 0 else { return false }

        shoppingList.remove(at: index)
        return true
    }

    func edit(at index: Int, with newValue: String) -> Bool {
        guard index < shoppingList.count, index >= 0 else { return false }

        shoppingList[index] = newValue
        return true
    }
}
