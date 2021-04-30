//
//  LoginViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/6/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreLocation

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var Emailtxt: UITextField!
    
    @IBOutlet weak var Pwdtxt: UITextField!
    
    @IBOutlet weak var Mobnotxt: UITextField!
    
    @IBOutlet weak var errtxt: UILabel!
    
    @IBOutlet weak var Loginbtn: UIButton!
     private var locationManager:CLLocationManager?
  
    
    @IBOutlet weak var Regbtn: UIButton!
    var num : String = ""
    
    override func viewDidLoad() {
        
      
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        super.viewDidLoad()
        errtxt.alpha = 0
        self.Mobnotxt.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        
        let email = Emailtxt.text!
        let pword = Pwdtxt.text!
        let mobno = Mobnotxt.text!
        
        if email == "" || pword == "" || mobno == ""
        {
            return "Please Fill in All fields."
        }
        
        if isValidEmail(testStr: email) == false
        {
            return "please enter correct format of email in email"
        }
        
        if isPasswordValid(pword) == false
        {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        if isValidNum(value: mobno) == false
        {

            return "please enter correct number format to Mobile Number"
        }
        
        return nil
    }

    
    @IBAction func logginTaped(_ sender: Any) {
        
        let error = validateFields()
        let email = Emailtxt.text!
        let pword = Pwdtxt.text!
        let mobno = Mobnotxt.text!
        if error != nil
           {
               showError(error!)
           }
        else
           {
                self.errtxt.alpha = 0
              let db = Firestore.firestore()

        db.collection("users").getDocuments { (snap, error) in
                if error == nil && snap != nil
                {
                    for i in snap!.documentChanges{
                        

                        let mob = i.document.get("MobileNo") as! String
                        
                        if mob == mobno
                            {
                               
                                self.num = mob
                                print(self.num)
                            
                        }
                    }
                }
            }
            

        Auth.auth().signIn(withEmail: email, password: pword){
            (result, error) in

            if error != nil && self.num != mobno{

                self.errtxt.text = error!.localizedDescription
                self.errtxt.alpha = 1

            }
            else{
                self.errtxt.alpha = 0
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "TabBar") as! UITabBarController

                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()

            }


        }
        }
    }
    func showError(_ message:String){
           
           errtxt.text=message
           errtxt.alpha=1
           
       }
  func isPasswordValid(_ password : String) -> Bool{
      let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
      return passwordTest.evaluate(with: password)
  }
  
  func isValidEmail(testStr:String) -> Bool {
      print("validate emilId: \(testStr)")
      let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      let result = emailTest.evaluate(with: testStr)
      return result
  }
  
  func isValidNum(value: String) -> Bool {
      let PHONE_REGEX = "^(0)[0-9]{9,10}$"
      let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
      let result =  phoneTest.evaluate(with: value)
      return result
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
      
      let allow = "1234567890"
      let allowSet = CharacterSet(charactersIn: allow)
      let typedC = CharacterSet(charactersIn: string)
      return allowSet.isSuperset(of: typedC)
      
  }
        
}

