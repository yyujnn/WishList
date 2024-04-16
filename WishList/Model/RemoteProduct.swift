//
//  RemoteProduct.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import Foundation
import CoreData

// Decodable --> 외부 데이터(JSON)를 Swift의 데이터 모델로 변환하는데에 필요한 프로토콜
struct RemoteProduct: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
}

// 테이블 뷰 출력 임시 struct
struct TempProduct {
    let id: Int
    let title: String
    let price: Double
}

// 임시 Product 객체
let product1 = TempProduct(id: 1, title: "상품 1", price: 10.99)
let product2 = TempProduct(id: 2, title: "상품 2", price: 20.99)
