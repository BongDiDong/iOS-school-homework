//
//  ShoppingModel.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/2/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

class ShoppingModel: ShoppingList {
    private(set) var shoppingList = [String]()

    let maximumNumberOfItems = 10

    func add(_ item: String) -> Bool {
        guard shoppingList.count < 10 else { return false }

        shoppingList.append(item)
        return true
    }

    func remove(at index: Int) -> Bool {
        guard (0..<shoppingList.count).contains(index) else { return false }

        shoppingList.remove(at: index)
        return true
    }
}
