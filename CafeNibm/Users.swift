////
////  Users.swift
////  CafeNibm
////
////  Created by Ravindu Liyanage on 3/7/21.
////  Copyright © 2021 Ravindu Liyanage. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//protocol DocumentSerializable {
//    init?(dictionary:[String:Any])
//}
//
//struct users {
//    var email: String
//    var password: String
//    var MobileNo: String
//    
//    var dictionary:[String : Any]{
//        return[
//        
//            "email":email,
//            "password":password,
//            "MobileNo":MobileNo
//            
//        ]
//        
//    }
//}
//
//extension users : DocumentSerializable{
//    init?(dictionary: [String : Any]) {
//        guard let email = dictionary["email"] as? String,
//        let password = dictionary["password"] as? String,
//        let MobileNo = dictionary[""]
//    }
//    
//    
//}
