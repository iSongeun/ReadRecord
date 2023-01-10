//
//  ReviewWriteViewController.swift
//  ReadRecord
//
//  Created by 이송은 on 2022/12/14.
//

import SnapKit
import UIKit
import Kingfisher

final class ReviewWriteViewController : UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton : UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23, weight: .bold)
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        return button
    }()
    
   
    private lazy var contentsTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = presenter.contentsTextViewPlaceHolderText
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        
        textView.delegate = self
        return textView
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
       return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}
extension ReviewWriteViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {
            return
        }
        textView.text = nil
        textView.textColor = .label
    }
}
extension ReviewWriteViewController : ReviewWriteProtocol {
   
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .close,
            target : self,
            action : #selector(didTapLeftBarButton)
        )
        
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapRightBarButton)
            )
    }
    
    func showCloseAlertController(){
        let alertController = UIAlertController(title: "정말 닫으시겠습니까?", message: "작성중인 내용이 있습니다.", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "close", style: .destructive){_ in
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title : "cancel", style: .default)
        
        [closeAction,cancelAction].forEach{ action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
    func close(){
        self.dismiss(animated: true)
    }
    
    func setupViews(){
        view.backgroundColor = .systemBackground
        
        [bookTitleButton, contentsTextView, imageView].forEach{ view.addSubview($0)}
        
        bookTitleButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentsTextView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16)
        }
        imageView.snp.makeConstraints{
            $0.leading.equalTo(contentsTextView.snp.leading)
            $0.trailing.equalTo(contentsTextView.snp.trailing)
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16)
            $0.height.equalTo(200)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func presentToSearchBookViewController(){
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        vc.view.backgroundColor = .red
        present(vc, animated: true)
    }
    
    func updateViews(title : String, imageURL : URL?){
        bookTitleButton.setTitle(title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: imageURL)
    }
}

private extension ReviewWriteViewController{
    @objc func didTapLeftBarButton(){
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton(){
        presenter.didTapRightBarButton(contentsText: contentsTextView.text)
    }
    
    @objc func didTapBookTitleButton(){
        presenter.didTapBookTitleButton()
    }
}
