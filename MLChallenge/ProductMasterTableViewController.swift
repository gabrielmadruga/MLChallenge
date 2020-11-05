//
//  MasterTableViewController.swift
//  MLChallenge
//
//  Created by Gabriel Madruga on 11/5/20.
//

import UIKit

protocol ProductMasterTableViewControllerDelegate: class {
  func itemSelected(_ item: ProductSearchItem)
}

class ProductMasterTableViewController: UITableViewController {
    
    weak var delegate: ProductMasterTableViewControllerDelegate?
    var service: ProductSearchItemService!
    var searchController: UISearchController!
    var searchWorkItem: DispatchWorkItem?
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var items: [ProductSearchItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.setupBackgroundView()
        self.tableView.setMessage("👆\nUsa la barra de busqueda para\nbuscar en Mercadolibre")
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar en Mercado Libre"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        searchController.searchBar.tintColor = .darkText
        searchController.searchBar.searchBarStyle = .prominent
        // Hack to make background white
        searchController.searchBar.searchTextField.backgroundColor = .white
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                
                for view in backgroundview.subviews {
                    view.removeFromSuperview()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Flash
        let selectedItem = items[indexPath.row]
        delegate?.itemSelected(selectedItem)
        if let detailViewController = delegate as? ProductDetailViewController,
           let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}
    
extension ProductMasterTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWorkItem?.cancel()
        searchWorkItem = DispatchWorkItem.init { [weak self] in
            guard let self = self else { return }
            self.tableView.isUserInteractionEnabled = true
            if !self.isSearchBarEmpty {
                self.items = []
                self.tableView.reloadData()
                self.tableView.setMessage("Buscando... 🕵️‍♂️")
                self.service.items(matching: searchText) { [weak self] items in
                    guard let self = self else { return }
                    if self.isSearchBarEmpty { return } // user canceled the search after getting the results
                    guard let items = items else {
                        self.items = []
                        self.tableView.reloadData()
                        self.tableView.setMessage("🛰\nParece que no hay internet!\nVuelve a intentarlo")
                        return
                    }
                    if items.isEmpty {
                        self.tableView.setMessage("No hay resultados 😔")
                    } else {
                        self.tableView.removeMessage()
                    }
                    self.items = items
                    self.tableView.reloadData()
                }
            } else {
                self.items = []
                self.tableView.reloadData()
                self.tableView.setMessage("👆\nUsa la barra de busqueda para\nbuscar en Mercadolibre")
            }
        }
        tableView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchWorkItem?.cancel()
        searchWorkItem = DispatchWorkItem.init { [weak self] in
            self?.items = []
            self?.tableView.reloadData()
            self?.tableView.setMessage("👆\nUsa la barra de busqueda para\nbuscar en Mercadolibre")
        }
        DispatchQueue.main.async(execute: searchWorkItem!)        
    }
}
