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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: ExtendedField!
    @IBOutlet weak var passField: ExtendedField!
    
    
    
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

    @IBAction func signInButton(_ sender: ExtendedButton) {
        if let email = emailField.text, let pass = passField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("##### VLAD ##### We were able to authenticate with Firebase!")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    print("##### VLAD ##### We were unable to login with Firebase! Error: \(error.debugDescription)")
                    
                    //Need to create user
                    FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            print("##### VLAD ##### We were unable to create an account with Firebase! Error \(error.debugDescription)")
                        } else {
                            print("##### VLAD ##### We were able to authenticate with Firebase! ")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Check if the user is already authenticated before showing the screen.
        if let _ = KeychainWrapper.stringForKey(KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: self)
            print("##### VLAD ##### Already authenticated! ")
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("##### VLAD ##### We were unable to login with Firebase!")
            } else {
                print("##### VLAD ##### We were ABLE to login with Firebase!")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        print("##### VLAD ##### Data saved to keychain: \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: self)
    }
}

