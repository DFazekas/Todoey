//
//  ViewController.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-04-13.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemArray.append( Item("Find Mike") )
        itemArray.append( Item("Buy eggos") )
        itemArray.append( Item("Destroy demogorgon") )
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Controls how many elements to display in Tableview.
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Controls creating cells to be inserted into the Tableview.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        // Populate cell's text.
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Set cell's Done property value.
        cell.accessoryType = (item.done) ? .checkmark : .none
        
        return cell
    }


    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handles selecting Tableview Cell.
        
        // Toggle Done property of Item.
        let item = itemArray[indexPath.row]
        item.done = !item.done
        
        // Unselect Cell.
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Reload table.
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Handles adding new a Todo Item.
        
        var textField = UITextField() // Used for extending scope of AddTextField closure.
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Add action to UIAlert.
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // Append user entry into array of Todos.
            self.itemArray.append( Item(textField.text!) )
            
            // Persist TodoList array.
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // Reload data.
            self.tableView.reloadData()
        }
        alert.addAction(action)
        
        // Add TextField to UIAlert.
        alert.addTextField { (alertTextField) in
            // Add Placeholder.
            alertTextField.placeholder = "Create new item"
            
            // Extend the alertTextField scope.
            textField = alertTextField
        }
        
        // Display UIAlert.
        present(alert, animated: true, completion: nil)
    }
    
    
}

