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

// --> 코어 데이터 모델 추가하기(id, price, title)
