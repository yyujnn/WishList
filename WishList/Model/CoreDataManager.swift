//
//  CoreDataManager.swift
//  WishList
//
//  Created by 정유진 on 2024/04/15.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    // MARK: - CoreData에 상품 저장
    func saveWishProduct() {
        guard let context = self.persistentContainer?.viewContext else { return }

        let product = Product(context: context)

        product.id = 1
        product.title = "test1"
        product.price = 35.5

        try? context.save()
    }

    // MARK: - CoreData에서 상품 정보 불러오기
    func setProductList() {
        guard let context = self.persistentContainer?.viewContext else { return }

        // WishList 엔터티에 대한 fetch 요청 생성
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            // fetch 요청을 실행하여 상품 리스트 가져오기
            let productList = try context.fetch(fetchRequest)
            
            // 가져온 상품 리스트를 출력하거나 다른 작업 수행
            for product in productList {
                print("Product ID: \(product.id), Name: \(product.title), Price: \(product.price)")
            }
        } catch {
            // fetch 요청 중 에러 발생 시 처리
            print("Error fetching product list: \(error.localizedDescription)")
        }
    }

}
