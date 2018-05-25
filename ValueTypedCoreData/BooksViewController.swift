//
//  BooksViewController.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataModel: BooksDataModelProtocol = BooksDataModel()
    var store: Store?
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = store?.brand
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: false)
        }
        
        fetchBooks()
    }
    
    func fetchBooks() {
        guard let store = store else {
            return
        }
        
        dataModel.fetchBooks(for: store) { books in
            self.books = books
            self.tableView.reloadData()
        }
    }
    
}

extension BooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = books?[indexPath.row].title
        cell.detailTextLabel?.text = books?[indexPath.row].author?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notesViewController = NotesViewController()
        notesViewController.book = books?[indexPath.row]
        
        navigationController?.pushViewController(notesViewController, animated: true)
    }
    
}
