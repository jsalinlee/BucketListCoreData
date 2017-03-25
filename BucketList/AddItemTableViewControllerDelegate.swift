//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Jonathan Salin Lee on 3/18/17.
//  Copyright © 2017 Jonathan Salin Lee. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    func cancelButtonPressed(by controller: AddItemTableViewController)
    func addItem(by controller: AddItemTableViewController, with text: String?, at indexPath: IndexPath?)
}
