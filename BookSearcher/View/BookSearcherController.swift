//
//  ViewController.swift
//  BookSearcher
//
//  Created by Akhmad Talatov on 18/05/21.
//

import UIKit

class BookSearcherController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = SearchViewPresenter()
    
    private var cellId = "book_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setDelegate(delegate: self)
        searchBar.delegate = self
        setTableView()
    }

    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.rowHeight = 60

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailSegue" {
                if let viewController = segue.destination as? DetailController {
                    guard let row = tableView.indexPathForSelectedRow?.row else { return }
                    viewController.book = presenter.books[row]
                }
            }
        }

}

extension BookSearcherController: SearchViewPresenterDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    //MARK: - Table View methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookCell
        cell.setData(presenter.books[indexPath.row].volumeInfo)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
    
    //MARK: - Search bar methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            presenter.searchBook(query: searchText)
        }
        else {
            presenter.clearData()
        }
        
    }
    
    
    //MARK: - Presenter methods
    func onError(error: Error?) {

    }
    
    func onUpdate() {
        self.tableView.reloadData()
    }
}

