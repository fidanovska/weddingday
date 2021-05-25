//
//  ToDoViewController.swift
//  My Wedding Day
//
//  Created by Ivana Fidanovska on 12/15/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet var toDoTableView: UITableView!
    
    var ref: DatabaseReference!
    let uid = Auth.auth().currentUser?.uid
    var toDos = [ToDoEventModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        toDoTableView.separatorStyle = .none
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.rowHeight = 90
        ref = Database.database().reference().child("userInfo").child(uid!).child("ToDoList")
     
        showToDos()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDos.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        
        let toDo: ToDoEventModel
        toDo = toDos[indexPath.row]
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.taskLabel.text = toDo.event
        return cell
        
       }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = toDos[indexPath.row]
            toDos.remove(at: indexPath.row)
            toDoTableView.reloadData()
            self.deleteToDoTask(id: toDo.id!)
            
        }
    }
    
    func deleteToDoTask(id: String){
        ref.child(id).setValue(nil)
        self.toDoTableView.reloadData()
    }
    
    func showToDos(){
        ref = Database.database().reference().child("userInfo").child(uid!).child("ToDoList")
        ref.queryOrderedByKey().observe(.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.toDos.removeAll()
                
                for toDoEvents in snapshot.children.allObjects as! [DataSnapshot]{
                    let toDoObject = toDoEvents.value as? [String: AnyObject]
                    let toDoEvent = toDoObject?["toDo"]
                    let id = toDoObject?["id"]
                    
                    let toDo = ToDoEventModel(eventName: toDoEvent as? String, id: id as? String)
                    
                    self.toDos.append(toDo)
                }
                DispatchQueue.main.async {
                    self.toDoTableView.reloadData()
                }
                
            }
    }
    }
    
    @IBAction func addNewTaskButtonAction(_ sender: Any) {
        
        let toDoAlert = UIAlertController(title: "Add ToDo", message: "Add a new task", preferredStyle: .alert)
        toDoAlert.addTextField()
        
        let addToDoAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if  let newToDo = toDoAlert.textFields?.first?.text, newToDo.count > 0 {
                let key = self.ref.childByAutoId().key
                let toDo = ["id":key, "toDo": newToDo]
                self.ref.child(key!).setValue(toDo)
                self.toDos.append(contentsOf: self.toDos)
                self.toDoTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        toDoAlert.addAction(addToDoAction)
        toDoAlert.addAction(cancelAction)
        
        present(toDoAlert, animated: true, completion: nil)
    }
    
}
