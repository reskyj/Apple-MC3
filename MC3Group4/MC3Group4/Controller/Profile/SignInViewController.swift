//
//  SignInViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var secondSignInButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email: String = ""
    var password: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secondSignInButton.buttonDesignOne()
        
        
    }
    
    @IBAction func signInButtonClicked() {
        self.email = self.emailTextField.text!
        self.password = self.passwordTextField.text!
        
        if (self.email == "" || self.password == ""){
            self.callAlert(title: "Failed", message: "Please fill in the fields!")
            return
        }
        else{
            self.checkLoginCredentials()
        }
    }
    
    func checkLoginCredentials(){
        FirebaseReferences.databaseRef.observeSingleEvent(of: .value) { (snap) in
            if (snap.hasChildren() == false){
                self.callAlert(title: "Failed", message: "E-mail not registered!")
                return
            }
            else{
                FirebaseReferences.databaseRef.child("Users").observeSingleEvent(of: .value, with: { (snap) in
                    let temp = snap.value as! [String:[String:AnyObject]]
                    for (key, _) in temp{
                        let tempUser = temp[key]
                        if (tempUser!["email"] as! String == self.email){
                            let hashedPassword = SHA1.hexString(from: self.password)!
                            if (tempUser!["password"] as! String != hashedPassword){
                                self.callAlert(title: "Failed", message: "Wrong password!")
                                return
                            }
                            else{
                                self.callAlert(title: "Success", message: "You are now logged in!")
                                return
                            }
                        }
                    }
                    
                    self.callAlert(title: "Failed", message: "E-mail not registered!")
                    return
                })
            }
        }
    }
    
    func callAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
