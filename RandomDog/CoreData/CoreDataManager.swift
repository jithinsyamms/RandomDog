//
//  CoreDataManager.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import CoreData
import UIKit

class CoreDataManager {

    private lazy var storeContainer: NSPersistentContainer = {
        let storeContainer = NSPersistentContainer(name: "RandomDog")
        storeContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error  = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return storeContainer
    }()

    func getManagedContext() -> NSManagedObjectContext {
        return storeContainer.viewContext
    }
    
    func saveContext() {
        guard storeContainer.viewContext.hasChanges else {return}

        do {
            try storeContainer.viewContext.save()
        } catch let error as NSError {
            print("Error \(error), \(error.userInfo)")
        }
    }

    func getAllDogs() -> [RandomDog] {
        var dogs: [RandomDog] = []
        let request:NSFetchRequest = RandomDog.fetchRequest()
        let sortDescriptors = [NSSortDescriptor(key: "key", ascending: true)]
        request.sortDescriptors = sortDescriptors
        do {
            dogs = try getManagedContext().fetch(request)
        } catch let error {
            print("Error in getRandomDogs() \(error)")
        }
        return dogs
    }

    func addDog(key: NSString, image: UIImage) {
        let randomDog = RandomDog(context: getManagedContext())
        randomDog.key = String(key)
        randomDog.dogImage = image.jpegData(compressionQuality: 1.0)
        do {
            try getManagedContext().save()
            print("Image added to CoreData")
        } catch let error as NSError {
            print("Could not add Image \(error), \(error.userInfo)")
        }
    }

    func deleteDog(key: NSString) {
        let fetchRequest: NSFetchRequest = RandomDog.fetchRequest()
        let predicate = NSPredicate(format: "key == %@", key)
        fetchRequest.predicate = predicate
        if let dog = try? getManagedContext().fetch(fetchRequest).first {
            getManagedContext().delete(dog)
        }
    }

    func deleteAllDogs() {
        let fetchRequest: NSFetchRequest = RandomDog.fetchRequest()
        do {
            let dogs = try getManagedContext().fetch(fetchRequest)
            for dog in dogs {
                getManagedContext().delete(dog)
            }
        } catch let error {
            print("Error in deleteAllDogs \(error)")
        }
    }
}

