//
//  SignUpViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/6/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var pwdtxt: UITextField!
    @IBOutlet weak var mobnotxt: UITextField!
    @IBOutlet weak var regbtn: UIButton!
    @IBOutlet weak var errlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errlbl.alpha=0
        
        self.mobnotxt.delegate = self
        
    }
    
    func validateFields() -> String? {
        
        let email = emailtxt.text!
        let pword = pwdtxt.text!
        let mobno = mobnotxt.text!
        
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

    @IBAction func tapRegbtn(_ sender: Any) {
    
    
    let error = validateFields()
    
    if error != nil
    {
        showError(error!)
    }
    else
    {
        self.errlbl.alpha = 0
        let email = emailtxt.text!
        let pword = pwdtxt.text!
        let mobno = mobnotxt.text!
        
        Auth.auth().createUser(withEmail:email, password:pword) { (result, err) in

            if err != nil{
                self.showError("Error creating user")
            }
            else{
                let db = Firestore.firestore()

                db.collection("users").addDocument(data: ["email":email,"password":pword,"MobileNo":mobno,"uid":result!.user.uid]){
                    (error)in

                    if error != nil{
                        self.showError("error saving data")
                    }

                }
                self.transitionToLogin()
            }
        }
        
        }
    }
     
    func showError(_ message:String){
        
        errlbl.text=message
        errlbl.alpha=1
        
    }
    
    func transitionToLogin(){
        
        let loginViewController = storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
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
