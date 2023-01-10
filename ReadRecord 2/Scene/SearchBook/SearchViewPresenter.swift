//
//  SearchViewPresenter.swift
//  ReadRecord
//
//  Created by 이송은 on 2022/12/14.
//



import Foundation
import UIKit

protocol SearchBookProtocol {
    func setupViews()
    func dismiss()
    func reloadView()
}
protocol SearchBookDelegate {
    func selectBook(_ book : Book)
}
final class SearchBookpresenter : NSObject {
    private let viewController : SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    private let delegate : SearchBookDelegate
    
    private var books : [Book] = []
    init(viewController: SearchBookProtocol, delegate : SearchBookDelegate ) {
        self.viewController = viewController
        self.delegate = delegate
    }
    func viewDidLoad(){
        viewController.setupViews()
    }
}

extension SearchBookpresenter : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        bookSearchManager.request(from: searchText) { newBooks in
            self.books = newBooks
            self.viewController.reloadView()
        }
    }
}
extension SearchBookpresenter : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.selectBook(selectedBook)
        viewController.dismiss()
//        var selectResults : [Book] = []
//        let selectedBook = selectResults[indexPath.row]
    }
}

extension SearchBookpresenter : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].title
        
        return cell
    }
}
