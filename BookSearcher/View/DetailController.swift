//
//  DetailController.swift
//  BookSearcher
//
//  Created by Akhmad Talatov on 18/05/21.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var authorBook: UILabel!
    @IBOutlet weak var textBook: UITextView!
    
    var book: Book?
    
    private var imageUrl: URL? {
        didSet {
                getImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let authors = book?.volumeInfo.authors {
            authorBook.setArray(authors)
        }
        if let imageUrl = book?.volumeInfo.imageLinks?.thumbnail {
            self.imageUrl = URL(string: imageUrl)
        }
        
        titleBook.text = book?.volumeInfo.title
        textBook.text = book?.volumeInfo.description
    }
    
    
    func getImage() {
        if let url = imageUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
               let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = data, url == self?.imageUrl {
                        self?.mainImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
