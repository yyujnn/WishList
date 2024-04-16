//
//  CoreDataManager.swift
//  WishList
//
//  Created by 정유진 on 2024/04/15.
//

import UIKit
import CoreData

class CoreDataManager {
    
    let entityName = "Product" // ProductEntity?
    
    // viewContext 가져오기 --> CRUD
    private let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate가 초기화되지 않았습니다.")
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - SAVE: CoreData에 상품 저장
    func saveWishProduct() {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        object.setValue(1, forKey: "id")
        object.setValue("CoreData 테스트", forKey: "title")
        object.setValue(30.0, forKey: "price")
        
        do {
            try context.save()
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }

    // MARK: - READ: CoreData에서 상품 정보 불러오기
    func fetchCoreData() {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            guard let productList = try context.fetch(fetchRequest) as? [Product] else { return }
            productList.forEach {
                print($0.id)
                print($0.title)
                print($0.price)
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - DELETE
    func deleteData(id: Int) {
        guard let context = context else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
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


