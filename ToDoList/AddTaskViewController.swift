//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Aya on 06/03/2025.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var isCreated = true
    var editedTask  : ToDoData?
    var editedIndex : Int?
    
    
    @IBOutlet weak var taskImageView: UIImageView!
    
    @IBOutlet weak var titleTextFeild: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var mainButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreated == false
        {
            mainButton.setTitle("Edit", for: .normal)
            navigationItem.title = "Edit Task"
            
            if let task =  editedTask {
                titleTextFeild.text = task.title
                detailsTextView.text = task.details
                taskImageView.image = task.image
            }
        }

        
    }
    

    @IBAction func addTaskButton(_ sender: Any) {
        if isCreated {
            let todo =  ToDoData(title: titleTextFeild.text!,image: taskImageView.image,details: detailsTextView.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewTaskAdded"), object: nil, userInfo: ["addedTask" : todo]) //created notifaction to send data from this vc to another
            let alert = UIAlertController(title: "Done", message: "Task Added", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true,completion: nil)
            
            let closeAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
                self.tabBarController?.selectedIndex = 0
                self.titleTextFeild.text = ""
                self.detailsTextView.text = ""
            }
            alert.addAction(closeAction)
            
        }else{
            let todo = ToDoData(title: titleTextFeild.text!, image: taskImageView.image, details: detailsTextView.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentTaskEdited"), object: nil,userInfo: ["editedTask":todo,"editedTaskIndex":editedIndex])
            
            let alert = UIAlertController(title: "Done", message: "Task Edited", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true,completion: nil)
            
            let closeAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
                self.navigationController?.popViewController(animated: true)
                self.titleTextFeild.text = ""
                self.detailsTextView.text = ""
            }
            alert.addAction(closeAction)
        }
        
        
      // print(titleTextFeild.text)
       // print(detailsTextView.text)
    }
    
    
    @IBAction func addImageButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
}


extension AddTaskViewController :  UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true,completion: nil)
        taskImageView.image = image
    }
    
}
