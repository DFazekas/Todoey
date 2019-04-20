//
//  ViewController.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-04-13.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy eggos", "Destroy Demogorgon"]
    
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
}

