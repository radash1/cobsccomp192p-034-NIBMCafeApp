//
//  ItemViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/8/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import Firebase

class ItemViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nmlbl: UILabel!
    @IBOutlet weak var pclbl: UILabel!
    @IBOutlet weak var cntlbl: UILabel!
    
    
    
    var nm = ""
    var pc = ""
    var im = ""

   
    override func viewDidLoad() {
        super.viewDidLoad()
            
        nmlbl.text = nm
        pclbl.text = "Rs.\(pc)"
        
        guard let url = URL(string: im) else {
                   
                   return
               }
               let getDataTask = URLSession.shared.dataTask(with: url){ data, _, error in
                   
                   guard let data = data, error == nil else{
                           return
                       }
                   
                   DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.img.image = image
                   
                   }
               }
               getDataTask.resume()
        
            }
   
    
    @IBAction func tap(_ sender: UIStepper) {
        cntlbl.text = Int(sender.value).description
    }
    
    @IBAction func btntpd(_ sender: Any) {
        
        let user = Auth.auth().currentUser?.email
        
       let qty = cntlbl.text!
        
       let cn = Int(qty) ?? 0
       let prc = Int(pc) ?? 0
        
        let tot = cn * prc
        let ful =  Int(tot).description
        
        let db = Firestore.firestore()

        db.collection("cart").addDocument(data: ["user":user! ,"name":nm,"price":ful,"Quantity":qty,"pic":im])
        
           self.navigationController?.popViewController(animated: true)
        
    }
    
}

