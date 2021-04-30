//
//  HomeViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/6/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var wow: UIView!
    var catagory: [Tab] = []
    private var locationManager:CLLocationManager?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadData()
        wow.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cafe")
        tableView.rowHeight = 200
        tableView.pin(to: wow)
        tableView.separatorColor = UIColor.white
        self.navigationItem.title = "HOME"
       
        
    }
    
    @IBAction func TapFrd(_ sender: Any) {
        
        catagory.removeAll()
        
       
       loadData()
               
        
    }
    @IBAction func tapdnk(_ sender: Any) {
        
         catagory.removeAll()
        
        let db = Firestore.firestore()
                    
                    db.collection("categories").addSnapshotListener { (snap, err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        for i in snap!.documentChanges{
                            
                            let id = i.document.documentID
                            let name = i.document.get("name") as! String
                            let price = i.document.get("price") as! String
                            let pic = i.document.get("pic") as! String
                            let cat = i.document.get("category") as! String
                         
                             if cat == "drinks"
                             {
                                 self.catagory.append(Tab(id: id, name: name, price: price, pic: pic))
                             }
                         
                     
                        }
                     print()
                     self.tableView.reloadData()
                    }
             
        
    }
    @IBAction func tapnod(_ sender: Any) {
        
         catagory.removeAll()
        
        let db = Firestore.firestore()
                    
                    db.collection("categories").addSnapshotListener { (snap, err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        for i in snap!.documentChanges{
                            
                            let id = i.document.documentID
                            let name = i.document.get("name") as! String
                            let price = i.document.get("price") as! String
                            let pic = i.document.get("pic") as! String
                            let cat = i.document.get("category") as! String
                         
                             if cat == "noodles"
                             {
                                 self.catagory.append(Tab(id: id, name: name, price: price, pic: pic))
                             }
                         
                     
                        }
                     print()
                     self.tableView.reloadData()
                    }
             
        
    }
    @IBAction func tabkot(_ sender: Any) {
        
         catagory.removeAll()
        
        let db = Firestore.firestore()
                    
                    db.collection("categories").addSnapshotListener { (snap, err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        for i in snap!.documentChanges{
                            
                            let id = i.document.documentID
                            let name = i.document.get("name") as! String
                            let price = i.document.get("price") as! String
                            let pic = i.document.get("pic") as! String
                            let cat = i.document.get("category") as! String
                         
                             if cat == "kottu"
                             {
                                 self.catagory.append(Tab(id: id, name: name, price: price, pic: pic))
                             }
                         
                     
                        }
                     print()
                     self.tableView.reloadData()
                    }
             
        
    }
    @IBAction func TapBr(_ sender: Any) {
        
        catagory.removeAll()
        
        let db = Firestore.firestore()
                             
                             db.collection("categories").addSnapshotListener { (snap, err) in
                                 
                                 if err != nil{
                                     
                                     print((err?.localizedDescription)!)
                                     return
                                 }
                                 
                                 for i in snap!.documentChanges{
                                     
                                     let id = i.document.documentID
                                     let name = i.document.get("name") as! String
                                     let price = i.document.get("price") as! String
                                     let pic = i.document.get("pic") as! String
                                    let cat = i.document.get("category") as! String
                                   
                                  if cat == "buriyani"
                                  {
                                      self.catagory.append(Tab(id: id, name: name, price: price, pic: pic))
                                  }
                                  
                                                               
                                 }
                              print()
                              self.tableView.reloadData()
                              
                             }
        
               
        
    }
    func loadData(){

        let db = Firestore.firestore()
               
               db.collection("categories").addSnapshotListener { (snap, err) in
                   
                   if err != nil{
                       
                       print((err?.localizedDescription)!)
                       return
                   }
                   
                   for i in snap!.documentChanges{
                       
                       let id = i.document.documentID
                       let name = i.document.get("name") as! String
                       let price = i.document.get("price") as! String
                       let pic = i.document.get("pic") as! String
                       let cat = i.document.get("category") as! String
                    
                        if cat == "friedrice"
                        {
                            self.catagory.append(Tab(id: id, name: name, price: price, pic: pic))
                        }
                    
                
                   }
                print()
                self.tableView.reloadData()
               }
        
        
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "item") as? ItemViewController
        
        vc?.nm = catagory[indexPath.row].name
        vc?.pc = catagory[indexPath.row].price
        vc?.im = catagory[indexPath.row].pic
        navigationController?.pushViewController(vc!, animated: true)
       
        
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
    
    

    
    
}

extension UIView {
    
    func pin(to wow: UIView){
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: wow.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: wow.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: wow.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: wow.bottomAnchor).isActive = true
        
    }
    
}


