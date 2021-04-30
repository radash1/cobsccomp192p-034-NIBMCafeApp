//
//  ForgetPassViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 4/27/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ForgetPassViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var errlbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
     func validateFields() -> String?{
        
         let em = email.text!
        
        if em == ""
               {
                   return "Please Fill in All fields."
               }
        
        if isValidEmail(testStr: em) == false
               {
                   return "please enter correct format of email"
               }
        return nil
    }
   
    @IBAction func RepassTap(_ sender: Any) {
        
        let error = validateFields()
        let em = email.text!
        var myAlert = UIAlertController(title: "Success", message: "Password reset link has been send to yor email", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (ACTION) in
            self.navigationController?.popViewController(animated: true)
            
             self.navigationController?.popViewController(animated: true)
            
        }
        myAlert.addAction(okAction)
        if error != nil
                  {
                      showError(error!)
                  }
               else
                  {
                    self.errlbl.alpha = 0
                    Auth.auth().sendPasswordReset(withEmail: em){(error) in
                        
                        if error == nil{
                            self.errlbl.alpha = 0
                            self.present(myAlert, animated: true, completion: nil)
                        }else
                        {
                            self.errlbl.text = error!.localizedDescription
                            self.errlbl.alpha = 1

                        }
                        
                    }
                    
        }
        
    }
   
    func isValidEmail(testStr:String) -> Bool {
         print("validate emilId: \(testStr)")
         let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
         let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         let result = emailTest.evaluate(with: testStr)
         return result
     }
    

    func showError(_ message:String){
           
           errlbl.text=message
           errlbl.alpha=1
           
       }
}
