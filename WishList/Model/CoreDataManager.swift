//
//  CoreDataManager.swift
//  WishList
//
//  Created by 정유진 on 2024/04/15.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let entityName = "Product"
    
    // viewContext 가져오기 --> CRUD
    static let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate가 초기화되지 않았습니다.")
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - SAVE: CoreData에 상품 저장
    static func saveWishProduct(product: RemoteProduct, completion: @escaping (Bool) -> Void) {
        guard let context = CoreDataManager.context else {
            completion(false)
            return
        }
        
        let wishProduct = Product(context: context)
        wishProduct.id = Int64(product.id)
        wishProduct.title = product.title
        wishProduct.price = product.price
        wishProduct.brand = product.brand
        
        do {
            try context.save()
            completion(true)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false)
        }
    }

    // MARK: - READ: CoreData에서 상품 정보 불러오기
    static func fetchCoreData() -> [Product] {
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<Product>(entityName: entityName)
        
        do {
           let productList = try context.fetch(fetchRequest)
            productList.forEach {
                print($0.id)
                print($0.title ?? "title")
                print($0.price)
            }
            return productList
        } catch {
            print("코어 데이터 fetch error: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - DELETE: CoreData에서 상품 삭제
    static func deleteProduct(withId id: Int64, completion: @escaping (Bool) -> Void) {
        guard let context = CoreDataManager.context else {
            completion(false)
            return
        }
        
        let fetchRequest = NSFetchRequest<Product>(entityName: CoreDataManager.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        
        do {
            let products = try context.fetch(fetchRequest)
            for product in products {
                context.delete(product)
            }
            try context.save()
            completion(true)
        } catch {
            print("Error deleting product: \(error.localizedDescription)")
            completion(false)
        }
    }
}
