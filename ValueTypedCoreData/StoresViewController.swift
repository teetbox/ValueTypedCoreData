//
//  StoresViewController.swift
//  ValueTypedCoreData
//
//  Created by Matt Tian on 2018/5/25.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import UIKit

class StoresViewController: UIViewController {
    
    @IBOutlet weak var amazonButton: UIButton!
    @IBOutlet weak var safariButton: UIButton!
    
    let dataModel: StoresDataModelProtocol = StoresDataModel()
    var stores: [Store]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Stores"
        
        amazonButton.setTitle("Hello", for: .normal)
        safariButton.setTitle("Swift", for: .normal)
        
        fetchStores()
    }
    
    func fetchStores() {
        dataModel.fetchStores { stores in
            self.stores = stores
            
            guard let amazon = stores?[0].brand else { return }
            guard let safari = stores?[1].brand else { return }
            
            self.amazonButton.setTitle(amazon, for: .normal)
            self.safariButton.setTitle(safari, for: .normal)
        }
    }
    
    @IBAction func showAmazon(_ sender: UIButton) {
        guard let amazon = stores?[0] else {
            return
        }
        showBooks(for: amazon)
    }
    
    @IBAction func showSafari(_ sender: UIButton) {
        guard let safari = stores?[1] else {
            return
        }
        showBooks(for: safari)
    }
    
    private func showBooks(for store: Store) {
        let booksViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BooksViewController") as! BooksViewController
        booksViewController.store = store
        navigationController?.pushViewController(booksViewController, animated: true)
    }
    
}
