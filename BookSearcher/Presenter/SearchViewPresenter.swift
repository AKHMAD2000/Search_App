//
//  SearchViewPresenter.swift
//  BookSearcher
//
//  Created by Akhmad Talatov on 18/05/21.
//

import Foundation
import UIKit

protocol SearchViewPresenterDelegate {
    func onError(error: Error?)
    func onUpdate()
}

typealias SearchViewDelegate = SearchViewPresenterDelegate & UIViewController

class SearchViewPresenter {
    
    weak var delegate: SearchViewDelegate?

    var books: [Book] = []
    
    var task: URLSessionDataTask?
    
    func setDelegate(delegate: SearchViewDelegate){
        self.delegate = delegate
    }
    func clearData() {
        books = []
        delegate?.onUpdate()
    }
    
    func searchBook(query: String) {
        task?.cancel()
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query)") else { return }
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(Books.self, from: data!)
                    self?.books = responseData.items
                    DispatchQueue.main.async {
                        self?.delegate?.onUpdate()

                    }
                }
                catch {
                    print("Error in parsing JSON")
                    }
            }
            else {
                self?.delegate?.onError(error: error)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.task?.resume()
        }
    }
}
