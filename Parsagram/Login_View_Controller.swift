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
    }
    
    
    @IBAction func sign_in(_ sender: Any) {
        
        // get text values from textboxes
        let username = username_textbox.text!
        let password = password_textbox.text!
        
        // call this function to authenticate user in database
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
            // if successful, go to feed view
            self.performSegue(withIdentifier: "successful_login", sender: nil)
          }
          
          else {
            // The login failed. Check error to see why.
            print("Error: \(error?.localizedDescription).")
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
                // if successful, go to feed view
                self.performSegue(withIdentifier: "successful_login", sender: nil)
            }
            
            else {
                print("Error: \(error?.localizedDescription).")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
