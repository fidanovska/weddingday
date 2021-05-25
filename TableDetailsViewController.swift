//
//  TableDetailsViewController.swift
//  My Wedding Day
//
//  Created by Ivana Fidanovska on 3/28/21.
//  Copyright © 2021 Fidanovska. All rights reserved.
//

import UIKit
import Firebase

class TableDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet var tableNoLabel: UILabel!
    @IBOutlet var tableNameLabel: UILabel!
    @IBOutlet var regularMenuLabel: UILabel!
    @IBOutlet var veganMenuLabel: UILabel!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    
    @IBOutlet var guestsOnTableTableView: UITableView!
    
    var guestLists = [GuestModel]()
    var guestList = [String]()
    var menuList = [String]()
    var tableData: TableModel?
    var refGuests:DatabaseReference!
    let uid = Auth.auth().currentUser?.uid
    var updatedGuestList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestsOnTableTableView.delegate = self
        guestsOnTableTableView.dataSource = self
        viewSetUp()
        tableNameAndNo()
        menuCount()
        guestList = tableData?.guests ?? [String]()
        self.navigationController?.navigationBar.isHidden = false
        guestsOnTableTableView.reloadData()
        guestsOnTableTableView.separatorStyle = .none
    }
    
    func tableNameAndNo(){
        
        let tableNo = tableData?.tableNo
        let tableName = tableData?.tableName
        tableNoLabel.text = "Table No." + " " + tableNo!
        tableNameLabel.text = tableName!
        
    }
    
    func menuCount(){
        menuList = tableData?.menus ?? [String]()
        let regularMenu = menuList.filter ({$0 == "regular"}).count
        let veganMenu = menuList.filter ({$0 == "vegan"}).count
        regularMenuLabel.text = "Regular menu: \(regularMenu)"
        veganMenuLabel.text = "Vegan menu: \(veganMenu)"
    }
    
    func viewSetUp(){
        firstView.layer.cornerRadius = 20
        secondView.layer.cornerRadius = 20
        firstView.layer.masksToBounds = true
        secondView.layer.masksToBounds = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestsCell", for: indexPath) as! GuestListOnTableTableViewCell
        
        let guest = guestList[indexPath.row]
        
        cell.guestNameLabel.text = guest
        return cell
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete from table"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
         
//            let tableId = tableData?.id
//            refGuests = Database.database().reference().child("userInfo").child(uid!).child("tables").child(tableId!).child("guestsOnTable")
//            let key = refGuests.childByAutoId().key
//            self.refGuests.updateChildValues(["id": key ?? "X", "tableName": entertableNameTextField.text! as String, "tableCapacity": tableCapacityTextField.text! as String, "tableNo": enterTableNumber.text! as String, "guestsOnTable" : indexArray as [String], "menu": indexMenu as [String]] as [String : Any])
//
//
//            ref.child(key!).setValue(table)
//
            
            
            let guestName = guestList[indexPath.row]
            if let tableId = tableData?.id{
                refGuests = Database.database().reference().child("userInfo").child(uid!).child("tables").child(tableId).child("guestsOnTable")
                refGuests.observe(.value) { (snapshot) in
                    if let guests = snapshot.value as? [String] {
                        for i in 0..<guests.count{
                            if guests[i] == guestName {
                                self.refGuests.child("userInfo").child(self.uid!).child("tables").child(tableId).child("guestsOnTable").child("\(i)").removeValue()
                                print(tableId)

                                self.guestList.remove(at: indexPath.row)
                                self.guestsOnTableTableView.reloadData()
                              break
                            }

                        }
                    }
                }
            }

           
        }
    }
}

