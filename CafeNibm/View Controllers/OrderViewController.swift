//
//  OrderViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 4/29/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import Firebase

class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
     var catagory: [Ord] = []
    @IBOutlet weak var tableView: UITableView!
    var sat = ""
    var us = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        self.navigationItem.title = "Orders"
       
    }
    func loadData(){
               us = (Auth.auth().currentUser?.email)!
               let db = Firestore.firestore()
                      db.collection("Orders").addSnapshotListener { (snap, err) in

                          if err != nil{
                              
                              print((err?.localizedDescription)!)
                              return
                          }
                          
                          for i in snap!.documentChanges{
                              
                            
                            let name = i.document.get("cus_name") as! String
                            let price = i.document.get("price") as! String
                            let status = i.document.get("status") as! Int
                            let food = i.document.get("food_Id") as! String
                            
                            if status == 1
                            {
                                self.sat = "Requesting"
                            }
                            else if status == 2
                            {
                                self.sat = "processing"
                            }
                            
                             if name == self.us
                            {
                                self.catagory.append(Ord(name: name,price: price, stat: status,fd: food))
                                                           }
                          }
                    
                       self.tableView.reloadData()
                       
                      }
               
               
               
           }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return catagory.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OdViewCell
         let Category = catagory[indexPath.row]
        cell.foodtxt.text = Category.fd
        cell.prctxt.text = "Rs.\(Category.price)"
        cell.stattxt.text = sat
    
        return cell
     }

}

struct Ord {
    var name : String
    var price : String
    var stat : Int
    var fd : String
}
