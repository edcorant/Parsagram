//
//  Camera_View_Controller.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/2/20.
//

import UIKit

class Camera_View_Controller: UIViewController {
    
    @IBOutlet weak var photo_to_post: UIImageView!
    @IBOutlet weak var caption_textbox: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit_post(_ sender: Any) {
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
