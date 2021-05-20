//
//  BookCell.swift
//  BookSearcher
//
//  Created by Akhmad Talatov on 18/05/21.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData( _ bookInfo: VolumeInfo) {
        self.title.text = bookInfo.title
        if let authors = bookInfo.authors {
            self.author.setArray(authors)
        }
        if let imageName: String = bookInfo.imageLinks?.smallThumbnail {
            guard let url = URL(string: imageName) else { return }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self?.imageBook.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}
