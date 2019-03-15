//
//  ViewController.swift
//  Todoey
//
//  Created by Rustam Bensalem on 3/13/19.
//  Copyright © 2019 Rustam Bensalem. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [CellModel]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell1 = CellModel()
        let cell2 = CellModel()
        let cell3 = CellModel()
        let cell4 = CellModel()
        cell1.name = "1"
        cell2.name = "2"
        cell3.name = "3"
        cell4.name = "4"
        itemArray.append(cell1)
        itemArray.append(cell2)
        itemArray.append(cell3)
        itemArray.append(cell4)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        if let items  = defaults.array(forKey: "TodoListArray") as? [CellModel] {
            itemArray = items
        }
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].name
        
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = item.checked ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
    
    
    @IBAction func AddToDoItem(_ sender: UIBarButtonItem) {
        
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let addedItem = CellModel()
            addedItem.name = newItemText.text!
            self.itemArray.append(addedItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Add item here"
            newItemText = textField
        }
        
        self.present(alert, animated: true)
        
    }
    

}

