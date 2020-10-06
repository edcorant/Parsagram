//
//  Login_View_Controller.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/1/20.
//

import UIKit
import Parse

class Login_View_Controller: UIViewController {
    
    @IBOutlet weak var username_textbox: UITextField!
    @IBOutlet weak var password_textbox: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "parsagram_login", sender: nil)
        }
    }
    
    
    @IBAction func sign_in(_ sender: Any) {
        
        // get text values from textboxes
        let username = username_textbox.text!
        let password = password_textbox.text!
        
        // call this function to authenticate user in database
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user: PFUser?, error: Error?) -> Void in
            
            if user != nil {
                self.clear_textboxes()
                // if successful, go to feed view
                self.performSegue(withIdentifier: "parsagram_login", sender: nil)
            }
            
            else {
                print("Error: \(error?.localizedDescription ?? "Sign In Failed").")
            }
        }
    }
    
    
    @IBAction func sign_up(_ sender: Any) {
        
        // create a new user object
        let user = PFUser()
        // get text values from textboxes
        user.username = username_textbox.text
        user.password = password_textbox.text
        
        // call this function from to write new user to database
        user.signUpInBackground { (success, error) in
            if success {
                self.clear_textboxes()
                // if successful, go to feed view
                self.performSegue(withIdentifier: "parsagram_login", sender: nil)
            }
            
            else {
                print("Error: \(error?.localizedDescription ?? "Sign Up Failed").")
            }
        }
    }
    
    func clear_textboxes () {
        self.username_textbox.text = ""
        self.password_textbox.text = ""
    }
    
    
    // send keyboard away by tapping anywhere
    @IBAction func on_tap(_ sender: Any) {
        view.endEditing(true)
    }
}
