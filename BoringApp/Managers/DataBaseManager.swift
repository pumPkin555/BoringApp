//
//  DataBaseManager.swift
//  BoringApp
//
//  Created by Ivanov Viktor on 27.09.2021.
//

import UIKit
import CoreData

class DataBaseManager {
    
    static let shared: DataBaseManager = DataBaseManager()
    let managedContext = appDelegate?.persistentContanier.viewContext
    
    var savedData: [SavedBoredActivity]? {
        get {
            return getDataFromDataBase()
        }
    }
    
    private func getDataFromDataBase() -> [SavedBoredActivity] {
        
        var resultArray: [SavedBoredActivity] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContanier.viewContext
        
        let fetchRequest: NSFetchRequest<SavedBoredActivity> = SavedBoredActivity.fetchRequest()
        
        do {
            resultArray = try context.fetch(fetchRequest)
        } catch {
            resultArray = []
            print(error.localizedDescription)
        }
        
        return resultArray
    }
    
    func saveActivity(with model: BoredActivity) {
        
        //        let context = appDelegate.persistentContanier.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavedBoredActivity", in: managedContext!)
        let taskObject = NSManagedObject(entity: entity!, insertInto: managedContext) as! SavedBoredActivity
        
        taskObject.activity = model.activity
        taskObject.type = model.type
        taskObject.price = model.price
        taskObject.key = model.key
        taskObject.link = model.link
        taskObject.participants = Int64(model.participants)
        taskObject.accessibility = model.accessibility
        
        saveContext()
    }
    
    func deleteFromEntity(with model: SavedBoredActivity) {
        managedContext?.delete(model)
        saveContext()
    }
    
    func saveContext() {
        do {
            try self.managedContext?.save()
        } catch {
            print("FUCK ERROR")
        }
    }
}
