//
//  ResultData.swift
//  Color
//
//  Created by James Wang on 1/23/17.
//  Copyright © 2017 DanielW. All rights reserved.
//

import Foundation
import CoreData
import UIKit



class ResultData: NSObject, NSCoding {
    
    
    //MARK: Properties
    
    var ans: [Int] = [0,0,0,0,0]
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("answers")
    
    
    struct PropertyKey {
        static let ans = "ans"
    }
    
    
    //MARK: Initialization
    
    init?(answer:[Int]) {
        
        // The name must not be empty
        guard !answer.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (answer.min()! >= 0) && (answer.max()! <= 99) else {
            return nil
        }
        
        // Initialize stored properties.
        self.ans = answer
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ans, forKey: PropertyKey.ans)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.ans) as? [Int] else {
            return nil
        }
        
        // Must call designated initializer.
        self.init(answer: name)
        
    }
}

/*class ResultData{
    
    func saveAnswer(_ q:Int, answer:Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Results",
                                                        in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)

        person.setValue(answer, forKey: "a\(q+1)")
        
        do {
            print("AJGDJGDAGDGAKJDKAJDKHA")
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchAnswer(_ q:Int) -> Int{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Results")
        
        do {
            var people = try managedContext.fetch(fetchRequest)
            return people.count
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return 0
    }
}*/
