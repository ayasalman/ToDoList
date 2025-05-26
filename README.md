📝 ToDo App

A simple and elegant iOS ToDo list app built with UIKit and Core Data that lets you create, edit, and delete tasks with images and descriptions — all stored persistently on-device.  

---

🚀 Features

- 📋 Addd new tasks with title, image, and detailed description.
- 🖊 Edit existing tasks.
- 🗑 Delete tasks with confirmation.
- 🖼 Pick an image using `UIImagePickerController`.
- 🧠 Local data persistence with Core Data.
- 🔄 Efficient communication between view controllers using `NotificationCenter`.
- 📱 Smooth and responsive user interface.
- ✅ Code quality enforced with SwiftLint


---

🧰 Technologies Used
Swift 5.0

UIKit

Core Data

Auto Layout

SwiftLint

MVC Architecture

---

🛠 Architecture

This app follows the MVC pattern , organized into:

- Model:
   `ToDoData.swift`: A Swift struct representing a task
   `StorageManger.swift`: Core Data logic for CRUD operations
   
- View:
   Custom `UITableViewCell`, storyboard-based UI
  
- Controller:
    `ToDoViewController.swift`: Main list of tasks
    `AddTaskViewController.swift`: Used for both creating and editing
    `DetailsViewController.swift`: Task details, edit and delete actions


---

 📂 Project Structure



 `ToDoData.swift`: Struct representing a task (title, image, and details) 
 `ToDoViewController.swift`: Main screen displaying the list of tasks 
 `AddTaskViewController.swift`: Form for adding and editing tasks 
 `DetailsViewController.swift`: Shows full task details with edit/delete options 
 `StorageManger.swift`: Core Data logic for CRUD operations 
 `ToDoTableViewCell.swift`: Custom cell to display task image and title 



---

📦 Core Data Operations


 Create
StorageManger.storeData(todo: ToDoData)

Read
let todos = StorageManger.getData()

Update
StorageManger.updateData(todo: updatedTask, index: taskIndex)

Delete
StorageManger.deleteData(index: taskIndex)

---

🛠 Requirements

iOS 13.0+

Xcode 14 or later

Swift 5.0+

UIKit-based application

---

📦 Installation

1- Clone the repo
2- Open ToDoApp.xcodeproj in Xcode
3- Build & run on a simulator or real device

---

📽 Demo Video

https://github.com/ayasalman/ToDoList/issues/1#issue-3092099323

---

📝 License This project is open-source and available under the MIT License.

---

👩‍💻 Author Aya iOS Developer
