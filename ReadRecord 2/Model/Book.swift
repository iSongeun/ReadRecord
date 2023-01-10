//
//  Book.swift
//  ReadRecord
//
//  Created by 이송은 on 2022/12/16.
//

import Foundation

struct Book : Decodable {
    let title : String
    private let image : String?
    
    var imageURL : URL? {URL(string: image ?? "")}
}
