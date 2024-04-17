//
//  NetworkingManager.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import Foundation

class NetworkingManager {
    let url = "https://dummyjson.com/products/"
    
    func fetchRemoteProduct(completion: @escaping (Result<RemoteProduct, Error>) -> Void) {
        // URLSession 인스턴스 생성
        let session = URLSession.shared
        let productID = Int.random(in: 1 ... 100)
        
        // URL 생성하여 RemoteProduct 가져오기
        if let url = URL(string: "\(url)\(productID)") {
            // URLSessionDataTask 사용하여 비동기적으로 데이터 요청
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let product = try JSONDecoder().decode(RemoteProduct.self, from: data)
                        completion(.success(product))
                        print("Decode Product: \(product)")
                    } catch {
                        completion(.failure(error))
                        print("Decode Error: \(error)")
                    }
                }
            }
            // 네트워크 요청 시작
            task.resume()
        }
    }
}
