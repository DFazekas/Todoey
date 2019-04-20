//
//  ViewController.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-04-13.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }


    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handles selecting Tableview Cell.
        
        // Apply checkmark to selected Cell.
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = (cell?.accessoryType == .checkmark) ? (.none) : (.checkmark)
        
        // Unselect Cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Handles adding new a Todo Item.
        
        var textField = UITextField() // Used for extending scope of AddTextField closure.
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Add action to UIAlert.
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // Append user entry into array of Todos.
            self.itemArray.append(textField.text!)
            
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

