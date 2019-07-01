//
//  ViewController.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-04-13.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Controls how many elements to display in Tableview.
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Controls creating cells to be inserted into the Tableview.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        // Populate cell's text.
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            // Set cell's Done property value.
            cell.accessoryType = (item.done) ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }


    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handles selecting Tableview Cell.
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
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
            
            // Append user entry into dynamic array of Todos.
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving Item, \(error)")
                }
            }
            
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
    
    func loadItems() {
        self.todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Filter Items, sorting by date created.
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!)
            .sorted(byKeyPath: "dateCreated", ascending: true)
        
        // Reload table.
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

