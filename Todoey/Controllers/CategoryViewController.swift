//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Devon Fazekas on 2019-06-02.
//  Copyright © 2019 Devon Fazekas. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Controls how many elements to display in Tableview.
        return self.categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Controls creating cells to be inserted into the Tableview.
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // Populate the Item's text.
        let category = self.categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "No categories added yet"
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get reference of destination view controller.
        let destinationVC = segue.destination as! TodoListViewController
        
        // Pass selected Category to destinationVC.
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categories?[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func loadCategories() {
        self.categories = realm.objects(Category.self)

        tableView.reloadData()
    }

    func save(category: Category) {
        do {
            try self.realm.write {
                realm.add(category)
            }
        } catch {
            print("Error trying to save context: \(error)")
        }
    }
    
    
    //MARK: - Add new Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField() // Used for extending scope of AddTextField closure.
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        // Add action to UIAlert.
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // Retrieve singleton app delegate.
            // PersistentContainer is only accessible through the object of Delegate, not the class.
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            // Persist array.
            self.save(category: newCategory)
            
            // Reload view.
            self.tableView.reloadData()
        }
        alert.addAction(action)
        
        // Add TextField to UIAlert.
        alert.addTextField { (alertTextField) in
            // Add placeholder.
            alertTextField.placeholder = "Create new Category"
            
            // Extend the alertTextField scope.
            textField = alertTextField
        }
        
        // Display UIAlert.
        present(alert, animated: true, completion: nil)
    }
    
}
