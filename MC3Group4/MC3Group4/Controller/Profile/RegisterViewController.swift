//
//  RegisterViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 16/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var secondRegisterButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var email: String = ""
    var fullName: String = ""
    var phone: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secondRegisterButton.buttonDesignOne()
        
    }
    
    
    @IBAction func registerButtonClicked() {
        self.email = self.emailTextField.text!
        self.fullName = self.fullNameTextField.text!
        self.phone = self.phoneTextField.text!
        self.password = self.passwordTextField.text!
        self.confirmPassword = self.confirmPasswordTextField.text!
        
        let alert = UIAlertController(title: "Failed", message:nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
        }
        alert.addAction(okAction)
        
        if (self.email == "" || self.fullName == "" || self.phone == "" || self.password == "" || self.confirmPassword == ""){
            alert.message = "Please fill in the fields!"
        }
        else if (self.password != self.confirmPassword){
            alert.message = "Password do not match!"
        }
        else{
            self.checkEmailExist()
            return
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkEmailExist(){
        FirebaseReferences.databaseRef.observeSingleEvent(of: .value) { (snap) in
            if (snap.hasChildren() == false){
                self.registerUserToDatabase()
                print("success")
            }
            else{
                FirebaseReferences.databaseRef.child("Users").observeSingleEvent(of: .value, with: { (snap) in
                    
                    let temp = snap.value as! [String:[String:AnyObject]]
                    for (key, _) in temp{
                        let tempUserEmail = temp[key]!["email"] as! String
                        if (tempUserEmail == self.email){
                            print("exists")
                            
                            let alert = UIAlertController(title: "Failed", message: "E-mail already exists!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                            }
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            return
                        }
                    }
           
                    self.registerUserToDatabase()
                    print("success")
                    
                })
            }
        }
    }
    
    func registerUserToDatabase(){
        let uuid = UUID().uuidString
        let hashedPassword: String = SHA1.hexString(from: self.password)!
        FirebaseReferences.databaseRef.child("Users/\(uuid)/email").setValue(self.email)
        FirebaseReferences.databaseRef.child("Users/\(uuid)/fullName").setValue(self.fullName)
        FirebaseReferences.databaseRef.child("Users/\(uuid)/phone").setValue(self.phone)
        FirebaseReferences.databaseRef.child("Users/\(uuid)/password").setValue(hashedPassword)
        FirebaseReferences.databaseRef.child("Users/\(uuid)/posts").setValue("")
        
        
        LoggedInUser.isLoggedIn = true
        LoggedInUser.user = UserModel(email: self.email, fullName: self.fullName, phone: self.phone, userUUID: uuid, posts: [])
        
        UserDefaultReference.udRef.set(true, forKey: "udLoggedIn")
        UserDefaultReference.udRef.set(self.email, forKey: "udEmail")
        UserDefaultReference.udRef.set(hashedPassword, forKey: "udHashedPassword")
        UserDefaultReference.udRef.set(uuid, forKey: "udUserUUID")
        
        let alert = UIAlertController(title: "Success", message: "You have successfully registered to _____!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: false)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
