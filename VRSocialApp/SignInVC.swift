//
//  ViewController.swift
//  VRSocialApp
//
//  Created by Volodymyr Romanov on 8/12/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    @IBAction func facebookButton(_ sender: ExtendedButton) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("##### VLAD ##### Can't login due to ERROR \(error)")
            } else if result?.isCancelled == true {
                print("##### VLAD ##### User cancelled facebook request")
            } else {
                print("##### VLAD ##### We were able to login with Facebook!")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("##### VLAD ##### We were unable to login with Firebase!")
            } else {
                print("##### VLAD ##### We were ABLE to login with Firebase!")
            }
        })
    }
}

