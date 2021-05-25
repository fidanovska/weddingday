//
//  UserProfile.swift
//  My Wedding Day
//
//  Created by Ivana Fidanovska on 12/27/20.
//  Copyright © 2020 Fidanovska. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserProfile {
    
    
    
    var partner1Name: String?
    var partner2Name: String?
    var dateOfEvent:String?
    var venue:String?
    var location: String?
    var id: String?
    var email: String?
    
   

    //MARK: - Constants

    static let KEY_PARTNER1_NAME = "partner1Name"
    static let KEY_PARTNER2_NAME = "partner2Name"
    static let KEY_DATE_OF_EVENT = "dateOfEvent"
    static let KEY_VENUE = "venue"
    static let KEY_LOCATION = "location"
    static let KEY_EMAIL = "email"


       var params:[String:Any]{
           get {
               var data = [String:Any]()
            data[UserProfile.KEY_PARTNER1_NAME] = partner1Name
            data[UserProfile.KEY_PARTNER2_NAME] = partner2Name
            data[UserProfile.KEY_DATE_OF_EVENT] = dateOfEvent
            data[UserProfile.KEY_VENUE] = venue
            data[UserProfile.KEY_LOCATION] = location
            data[UserProfile.KEY_EMAIL] = email
               //data[UserProfile.KEY_ID] = id
            return data
           }
       }

       init(user: User) {
           self.id = user.uid
           self.email = user.email
       }

       init(data: DocumentSnapshot) {
           self.id = data.documentID
        self.partner1Name = data[UserProfile.KEY_PARTNER1_NAME] as? String
        self.partner2Name = data[UserProfile.KEY_PARTNER2_NAME] as? String
        self.dateOfEvent = data[UserProfile.KEY_DATE_OF_EVENT] as? String
        self.venue = data[UserProfile.KEY_VENUE] as? String
        self.location = data[UserProfile.KEY_LOCATION] as? String
        self.email = data[UserProfile.KEY_EMAIL] as? String
       }
}
