//
//  ViewController.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-04-13.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        loadItems()
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
        
        saveItems()
        
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
            self.saveItems()
            
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
    
 
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            // TODO: Catch failure.
            print("Error encoding item array, \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
        
    }
}

