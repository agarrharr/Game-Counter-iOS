//
//  Score+CoreDataProperties.swift
//  Game Counter
//
//  Created by Adam Garrett-Harris on 9/8/21.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var value: Int16
    
    static func create(in context: NSManagedObjectContext) {
        let score = Score(context: context)
        score.value = 1
        
        do {
            try context.save()
        } catch {
            print("Error creating score")
        }
    }
    
    static func add(_ score: Score, number: Int, in context: NSManagedObjectContext) {
        score.value = score.value + Int16(number)
        
        do {
            try context.save()
        } catch {
            print("Error adding to score")
        }
    }
    
    static func delete(_ score: Score, in context: NSManagedObjectContext) {
        context.delete(score)
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension Score : Identifiable {

}
