//
//  Caching.swift
//  NagwaIosTask
//
//  Created by Ahmed Fitoh on 10/6/18.
//  Copyright © 2018 Orange. All rights reserved.
//

import Foundation
import UIKit
import CoreData


protocol CacheOperationDelegate {
   func saveDataLocaly (fetchedData : GithubModel)
   func retriveData () -> GithubModel
}

class CachingService : CacheOperationDelegate {
 
     func saveDataLocaly (fetchedData : GithubModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "GitHubElements", in: context)
        
        for item in fetchedData {
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(item.id, forKey: "id")
            newUser.setValue(item.fullName, forKey: "fullName")
            newUser.setValue(item.name, forKey: "name")
            newUser.setValue(item.forksCount, forKey: "forksCount")
            newUser.setValue(item.watchersCount, forKey: "watchersCount")

        }
        do {
            try context.save()
        } catch {
            print("Didn't Save")
        }
        context.reset()
    }
    func retriveData () -> GithubModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GitHubElements")
        request.returnsObjectsAsFaults = false
        var list : GithubModel = []
        do {
            let result = try context.fetch(request)
         
           for data in result as! [NSManagedObject] {
            let item = GithubModelElement(id: data.value(forKey: "id") as! Int,
                                          name: data.value(forKey: "name") as! String,
                                          fullName: data.value(forKey: "fullName") as! String,
                                          watchersCount: data.value(forKey: "watchersCount") as! Int,
                                          forksCount: data.value(forKey: "forksCount")  as! Int)
            list.append(item)
            }
            
            
        } catch {
            
            print("Failed")
        }
        return list
    }

}
