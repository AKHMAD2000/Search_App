//
//  Extensions.swift
//  BookSearcher
//
//  Created by Akhmad Talatov on 18/05/21.
//

import UIKit

// MARK: - UIImageView LOAD IMAGE FROM URL
extension UILabel {
    func setArray(_ array: [String]) {
        self.text =  array.joined(separator: ", ")
    }
}
