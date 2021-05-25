//
//  GuestDetailsViewController.swift
//  My Wedding Day
//
//  Created by Ivana Fidanovska on 2/10/21.
//  Copyright © 2021 Fidanovska. All rights reserved.
//

import UIKit
import Firebase

class GuestDetailsViewController: UIViewController {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneNoLabel: UILabel!
    
    var guestDetail = [GuestModel]()
    var guestUser: GuestModel?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        self.nameLabel.text = guestUser!.guestName
        self.phoneNoLabel.text = guestUser!.guestPhoneNumber
        self.emailLabel.text = guestUser!.guestEmail
        
    }

    @IBAction func sendEmailButtonAction(_ sender: Any) {
    }
    
    @IBAction func callButtonAction(_ sender: Any) {
    }
    
}
