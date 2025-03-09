//
//  DetailsViewController.swift
//  ToDoList
//
//  Created by Aya on 06/03/2025.
//

import UIKit

class DetailsViewController: UIViewController {
    var task : ToDoData!
    var index : Int!
    @IBOutlet weak var todoImageView: UIImageView!
    
    @IBOutlet weak var todoTitleLabel: UILabel!
    
    @IBOutlet weak var creationLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  task.image != nil{
            todoImageView.image = task.image
        }else{
            todoImageView.image = UIImage(named: "6")
        }
        
        setupUI()
       // creationLabel.text
        NotificationCenter.default.addObserver(self, selector: #selector(currentTaskEditied) , name: NSNotification.Name(rawValue: "CurrentTaskEdited"), object: nil)
        
    }
    
    @objc func currentTaskEditied(notification : Notification)
    {
        if let editedTask = notification.userInfo?["editedTask"] as? ToDoData
        {
            self.task = editedTask
            setupUI()
        }
    }
    
    func setupUI()
    {
        todoTitleLabel.text = task.title
        detailsLabel.text = task.details
        todoImageView.image = task.image
    }
    
    
    @IBAction func editTaskButton(_ sender: Any) {
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "AddTaskID") as? AddTaskViewController
        {
            viewController.isCreated = false
            viewController.editedTask = task
            viewController.editedIndex = index
            navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    

    @IBAction func deleteButton(_ sender: Any) {
        
        
        let confirmDeleteAlert = UIAlertController(title: "Delete Task", message: "Are you sure", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { alert in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteTask"), object: nil,userInfo: ["deleteIndex" : self.index])

            let alert = UIAlertController(title: "Done", message: "Task Deleted", preferredStyle: .alert)

            let closeAction = UIAlertAction(title: "Ok", style: .default) { alert in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(closeAction)
            self.present(alert, animated: true,completion: nil)
        }
        confirmDeleteAlert.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default,handler: nil)
        confirmDeleteAlert.addAction(cancelAction)
        present(confirmDeleteAlert, animated: true,completion: nil)
        
       
       
    }
    

}
