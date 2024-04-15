//
//  RemoteProduct.swift
//  WishList
//
//  Created by 정유진 on 2024/04/12.
//

import Foundation
import CoreData

struct RemoteProduct: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
}

// -> 코어 데이터 모델 추가하기(id, price, title)
