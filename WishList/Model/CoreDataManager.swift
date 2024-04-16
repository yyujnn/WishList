//
//  CoreDataManager.swift
//  WishList
//
//  Created by 정유진 on 2024/04/15.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let entityName = "Product" // ProductEntity?
    
    // viewContext 가져오기 --> CRUD
    private static let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate가 초기화되지 않았습니다.")
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - SAVE: CoreData에 상품 저장
    func saveWishProduct() {
        guard let context = CoreDataManager.context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: CoreDataManager.entityName, in: context) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue(1, forKey: "id")
        object.setValue("CoreData 테스트", forKey: "title")
        object.setValue(30, forKey: "price")
        
        do {
            try context.save()
        } catch {
            print("error: \(error.localizedDescription)")
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
                print($0.title)
                print($0.price)
            }
            
            return productList
        } catch {
            print("코어 데이터 fetch error: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - DELETE
    func deleteData(id: Int) {
        guard let context = CoreDataManager.context else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: CoreDataManager.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let result = try? context.fetch(fetchRequest),
                  let object = result.first as? NSManagedObject else { return }
            context.delete(object)
            
            try context.save()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
