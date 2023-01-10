//
//  BookSearchManager.swift
//  ReadRecord
//
//  Created by 이송은 on 2022/12/16.
//
//client id : RhYg0XwCSCCfvl5S5L0W
//client secret : 5P5uZX2J7z

import Foundation
import Alamofire

struct BookSearchManager{
    func request(from keyword : String, completionHandler : @escaping(([Book]) -> Void )){
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else {return}
        
        let parameters = BookSearchRequestModel(query: keyword)
        
        let headers : HTTPHeaders = [
            "X-Naver-Client-Id" : "RhYg0XwCSCCfvl5S5L0W",
            "X-Naver-Client-Secret" : "5P5uZX2J7z"
        ]
        
        AF.request(url,method: .get,parameters: parameters,headers: headers)
            .responseDecodable(of:BookSearchReponseModel.self) { response in
                switch response.result{
                case .success(let result) :
                    completionHandler(result.items)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }.resume()
    }
}
