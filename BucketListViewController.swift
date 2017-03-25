//
//  BucketListViewController.swift
//  BucketList
//
//  Created by Jonathan Salin Lee on 3/18/17.
//  Copyright © 2017 Jonathan Salin Lee. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
        } else if segue.identifier == "EditItem" {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! IndexPath
            addItemTableViewController.item = items[indexPath.row].text
            addItemTableViewController.indexPath = indexPath as IndexPath!
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(items[indexPath.row])
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    func addItem(by controller: AddItemTableViewController, with text: String?, at indexPath: IndexPath?) {
        print("Added item.")
        if let indexPath = indexPath {
            let item = items[indexPath.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
