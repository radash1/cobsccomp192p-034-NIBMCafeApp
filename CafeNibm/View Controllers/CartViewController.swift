//
//  CartViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/8/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    var tot = 0
    var catagory: [Tab] = []
    @IBOutlet weak var totlbl: UILabel!
    
    @IBOutlet weak var cat: UIView!
    private var locationManager:CLLocationManager?
    @IBOutlet weak var tableView: UITableView!
//    private let table: UITableView = {
//
//        let table = UITableView()
//        table.register(TableViewCell.self, forCellReuseIdentifier: "cafe")
//        return table
//    }()

    @IBOutlet weak var lblcnt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        cat.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cafe")
        tableView.pin(to: cat)
        tableView.rowHeight = 200
        self.navigationItem.title = "CART"

    }
    
    func loadData(){
        
        let db = Firestore.firestore()
               
               db.collection("cart").addSnapshotListener { (snap, err) in
                self.catagory.removeAll()
                   if err != nil{
                       
                       print((err?.localizedDescription)!)
                       return
                   }
                   
                   for i in snap!.documentChanges{
                       
                       let id = i.document.documentID
                       let name = i.document.get("name") as! String
                       let price = i.document.get("price") as! String
                       let pic = i.document.get("pic") as! String
                    
                    
                    
                    self.catagory.append(Tab(id: id, name: name, price: price, pic: pic))
                    self.tot += Int(price) ?? 0
                   }
                self.lblcnt.text = "Rs.\(Int(self.tot).description)"
                self.tableView.reloadData()
                
               }
        
        
        
        
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catagory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cafe", for: indexPath) as! TableViewCell
        let Category = catagory[indexPath.row]
        cell.set(tab: Category)
        return cell
    }
    
    @IBAction func orderTap(_ sender: Any) {
        
        
        let us = Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
          let db = Firestore.firestore()
        let now = Date()
        let fom = DateFormatter()
        fom.dateStyle = .short
        fom.timeStyle = .none

        let date = fom.string(from: now)
        print(date)
        

         let ful =  Int(tot).description
        
        

        db.collection("Cuser").addSnapshotListener { (snap, err) in
     
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
              
              let name = i.document.get("email") as! String
             
                
               if name == us!
                {
                    let pic = i.document.get("MobileNo") as! String
                    print(pic)
                }
              
            }
         
         
        }
        
        var ref: DocumentReference? = nil
               var foods:[NSDictionary] = []
               for item in catagory {
                   let dic = [
                    "name":item.name,
                       "price":item.price
                   ] as [String : Any]

                   foods.append(dic as NSDictionary)
               }
          
               ref = db.collection("Orders").addDocument(data: [
                   "time": date,
                   "Items":  foods ,
                   "price": ful,
                   "cus_name":us!,
                   "food_Id": "zxc123",
                   "status":1
               ]) { err in
//                   if let err = err {
//                       let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
//                       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                       self.present(alert, animated: true)
//                   } else {
//                       self.vm.foodArray.removeAll()
//                       self.appDelegate.arrFoodCart.removeAll()
//                       self.cartTableView.reloadData()
//                       self.collectionView.reloadData()
//                       self.lblItemCount.text = "0 Items"
//                       self.appDelegate.cartCount = 0
//                       self.totalPrice = 0
//                       self.btnOrder.setTitle("Order Rs. 0", for: .normal)
//                       let alert = UIAlertController(title: "Success", message: "Order Placed Successfully", preferredStyle: .alert)
//                       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                       self.present(alert, animated: true)
//                   }
//               }
//

        
        
    }
        db.collection("cart").whereField("user", isEqualTo: us!).getDocuments() { (querySnapshot, err) in
                     if let err = err {
                       print("Error getting documents: \(err)")
                     } else {
                       for document in querySnapshot!.documents {
                         document.reference.delete()
                           self.loadData()
                       }
                     }
        }
         self.navigationController?.popViewController(animated: true)
    }
}



