//
//  LoggedInViewController.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var addedProfileView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBAction func importProfilePicture(_ sender: Any) {
        
        let profilePicture = UIImagePickerController()
        profilePicture.delegate = self
        profilePicture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        profilePicture.allowsEditing = false
        
        self.present(profilePicture, animated: true) {
            
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let profilePicture = info[UIImagePickerControllerOriginalImage] as? UIImage   {
            profilePictureView.image = profilePicture
        } else {
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profilePictureView.layer.cornerRadius = profilePictureView.frame.size.width / 2
        self.profilePictureView.clipsToBounds = true
//        self.profilePictureView.layer.borderWidth = 5
//        self.profilePictureView.layer.borderColor = UIColor.white.cgColor
        self.addedProfileView.layer.cornerRadius = addedProfileView.frame.size.width / 2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (LoggedInUser.isLoggedIn == false){
            performSegue(withIdentifier: "LoggedInToProfile", sender: self)
        }
        else{
            self.fullNameLabel.text = LoggedInUser.user.fullName
            self.phoneLabel.text = LoggedInUser.user.phone
            self.emailLabel.text = LoggedInUser.user.email
        }
    }

}
