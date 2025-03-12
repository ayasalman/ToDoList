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
        
        toDoTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        
        self.toDoArray = StorageManger.getData()

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
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
    
    //notifiction center functions
    
    @objc func newTaskAdded (notification :  Notification)
    {
        
        
        if let addedTask = notification.userInfo?["addedTask"] as? ToDoData
        {
            toDoArray.append(addedTask)
            StorageManger.storeData(todo: addedTask)
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
                StorageManger.updateData(todo: editedTask, index: index)
            }
        }
    }
    
    @objc func deleteTask(notification : Notification)
    {
        if let index = notification.userInfo?["deleteIndex"] as? Int
        {
            toDoArray.remove(at: index)
            toDoTableView.reloadData()
            StorageManger.deleteData(index: index)
        }
      
    }
    
}
