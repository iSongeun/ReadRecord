//
//  ReviewListPresenter.swift
//  ReadRecord
//
//  Created by 이송은 on 2022/12/14.
//

import Foundation
import UIKit

protocol ReviewListProtocol{
    func setupNavigationBar()
    func setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter : NSObject {
    private let viewController : ReviewListProtocol
    private let userDefaultsManager = UserDefaultManager()
    
    private var review : [BookReview] = []
    
    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear(){
        //내용업데이트
        review = userDefaultsManager.getReviews()
        viewController.reloadTableView()
    }
    func didTapRightBarButtonItem(){
        viewController.presentToReviewWriteViewController()
    }

}

extension ReviewListPresenter : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = review[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
        cell.imageView?.kf.setImage(with: review.imageURL,placeholder: .none){ _ in
            cell.setNeedsLayout()
        }
        
        cell.selectionStyle = .none
        
        return cell
        
    }
}
