//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by Jonathan Salin Lee on 3/18/17.
//  Copyright © 2017 Jonathan Salin Lee. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    var indexPath: IndexPath?
    var item: String?
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = item
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = textField!.text
        delegate?.addItem(by: self, with: text, at: indexPath)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
