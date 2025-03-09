//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Aya on 05/03/2025.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
   
    var toDoArray : [ToDoData] = []
    
    @IBOutlet weak var toDoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toDoArray = getData()

        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        
        //new task notification
        NotificationCenter.default.addObserver(self, selector: #selector(newTaskAdded), name: NSNotification.Name(rawValue: "NewTaskAdded"), object: nil)
        
        //edit task noftification
        NotificationCenter.default.addObserver(self, selector: #selector(currentTaskEditied) , name: NSNotification.Name(rawValue: "CurrentTaskEdited"), object: nil)
        
        //delete task notification
        NotificationCenter.default.addObserver(self, selector: #selector(deleteTask) , name: NSNotification.Name(rawValue: "deleteTask"), object: nil)
    }
}




extension ToDoViewController :  UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        cell.todoTitleLabel.text = toDoArray[indexPath.row].title
        //cell.textLabel?.text = toDoArray[indexPath.row]
        if toDoArray[indexPath.row].image != nil
        {
            cell.todoImageView.image = toDoArray[indexPath.row].image
        }
        else
        {
            cell.todoImageView.image = UIImage(named: "9")
        }
        cell.todoImageView.layer.cornerRadius = cell.todoImageView.frame.width  / 2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("hello")
        let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsID") as? DetailsViewController
        let todo = toDoArray[indexPath.row]
        if let viewController = detailsViewController
        {
            viewController.task = todo
            viewController.index = indexPath.row
            //present(viewController, animated: true,completion: nil)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}




extension ToDoViewController
{
    //core Data functions
    
    func storeData(todo : ToDoData)
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
    
    
    
    func getData() -> [ToDoData]
    {
        var task : [ToDoData] = []
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
                toDoArray.append(task)
                
            }
            
            
            
        }catch{
            print("========error=======")
        }
        return toDoArray
    }
    
    func updateData(todo : ToDoData , index :Int)
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
    
    func deleteData(index : Int)
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





extension ToDoViewController
{
    
    //notifiction center functions
    
    @objc func newTaskAdded (notification :  Notification)
    {
        
        
        if let addedTask = notification.userInfo?["addedTask"] as? ToDoData
        {
            toDoArray.append(addedTask)
            storeData(todo: addedTask)
            toDoTableView.reloadData()
        }
        
        
        
        
    }
    
    @objc func currentTaskEditied(notification : Notification)
    {
        if let editedTask = notification.userInfo?["editedTask"] as? ToDoData
        {
            if let index = notification.userInfo?["editedTaskIndex"] as? Int
            {
                toDoArray[index] = editedTask
                toDoTableView.reloadData()
                updateData(todo: editedTask, index: index)
            }
        }
    }
    
    @objc func deleteTask(notification : Notification)
    {
        if let index = notification.userInfo?["deleteIndex"] as? Int
        {
            toDoArray.remove(at: index)
            toDoTableView.reloadData()
            deleteData(index: index)
        }
      
    }
    
}
