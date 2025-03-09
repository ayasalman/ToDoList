//
//  StorageManger.swift
//  ToDoList
//
//  Created by Aya on 09/03/2025.
//


import UIKit
import CoreData


class StorageManger
{
    //core Data functions
    
    
    //Creat
    static func storeData(todo : ToDoData)
    {
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else{return}
        let mangeContext = appDelegate.persistentContainer.viewContext
        guard let taskEntity = NSEntityDescription.entity(forEntityName: "Tasks", in: mangeContext) else { return  }
        let task = NSManagedObject.init(entity: taskEntity, insertInto: mangeContext)
        task.setValue(todo.title, forKey: "title")
        task.setValue(todo.details, forKey: "details")
        if let image = todo.image
        {
            let imageData = image.jpegData(compressionQuality: 0.8)
            task.setValue(imageData, forKey: "image")
        }
        
        do{
            try mangeContext.save()
            print("=========success========")
        }catch{
            print(" ==========error========")
        }
    }
    
    
    
    //Read
    
    
    
    static func getData() -> [ToDoData]
    {
        var tasksArray : [ToDoData] = []
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {return []}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        
        do{
            let result = try context.fetch(fetchRequest)  as! [NSManagedObject]
            for managedTask in result {
                let title = managedTask.value(forKey: "title") as? String
               let details = managedTask.value(forKey: "details") as? String
                var todoImage : UIImage? = nil
                if let imageFromContext = managedTask.value(forKey: "image") as? Data
                {
                    todoImage = UIImage(data: imageFromContext)
                }
                
                let task = ToDoData(title: title ?? "",image: todoImage,details: details ?? "")
                tasksArray.append(task)
                
            }
            
            
            
        }catch{
            print("========error=======")
        }
        return tasksArray
        
    }
    
    
    
    
    

    
   
    //Update
    
    static func updateData(todo : ToDoData , index :Int)
    {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let context  =  appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        
        do{
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            result[index].setValue(todo.title, forKey: "title")
            result[index].setValue(todo.details, forKey: "details")
            if let image =  todo.image
            {
                let imageData = image.jpegData(compressionQuality: 0.8)
                result[index].setValue(imageData, forKey: "image")
            }
            
            
            try context.save()
            
        }catch{
            print("======error======")
        }
        
    }
    

    
    
    //Delete
    
    static func deleteData(index : Int)
    {
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        
        do{
            let result =  try context.fetch(fetchRequest) as! [NSManagedObject]
            let taskDelete = result[index]
            context.delete(taskDelete)
            
            try context.save()
            
        }catch{
            print("========Error=======")
        }
    }
    
    
    
}
