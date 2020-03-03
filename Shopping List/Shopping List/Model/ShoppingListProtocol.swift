//
//  ShoppingListProtocol.swift
//  Shopping List
//
//  Created by Андрей Погосский on 3/2/20.
//  Copyright © 2020 Андрей Погосский. All rights reserved.
//

protocol ShoppingList {
    /// Stores items to shop
    var shoppingList: [String] { get }

    /**
     Adds the item in the end of the list.
     
     - Parameter: item: Item to add into a `shoppingList`.
     - Returns: `true` if the `item` was added into a `shoppingList`, otherwise `false`.
     */
    func add(_ item: String) -> Bool

    /**
     Removes the item from the list.
     
     - Parameter item: Item to remove from a `shoppingList`.
     - Returns: `true` if the `item` was removed from a `shoppingList`, otherwise `false`.
     */
    func remove(_ item: String) -> Bool

    /**
     Removes the item at specified index from the list.
     
     - Parameter index: The position of the element in the `shoppingList` to remove.
     - Returns: `true` if the item at `index` was removed from a `shoppingList`, otherwise `false`.
     */
    func remove(at index: Int) -> Bool

    /**
     Edit the item at specified index from the list.
     
     - Parameter index: The position of the element in the `shoppingList` to edit.
     - Parameter newItem: replace old item with `newItem`.
     - Returns: `true `  if the item at `index` was successfully edited, otherwise `false`.
     */
    func edit(at index: Int, with newItem: String) -> Bool
}
