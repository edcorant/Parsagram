//
//  Camera_View_Controller.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/2/20.
//

import UIKit
import AlamofireImage
import Parse

class Camera_View_Controller: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photo_to_post: UIImageView!
    @IBOutlet weak var caption_textbox: UITextField!
    @IBOutlet weak var take_or_pick: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func submit_post(_ sender: Any) {
        
        // new object in "Posts" table
        let post = PFObject(className: "Posts")
        
        // upload object's owner
        post["Owner"] = PFUser.current()
        // upload the picture itself as PFFileObject
        post["Image"] = PFFileObject(data: photo_to_post.image!.pngData()!)
        // upload caption
        post["Caption"] = caption_textbox.text ?? ""
        
        // flush post object to disc
        post.saveInBackground { (success, error) in
            if success {
                print("Success!")
                // dismiss current view upon successful post
                self.cancel(0)
            }
            
            else {
                print("Error: \(error?.localizedDescription).")
            }
        }
    }
    
    @IBAction func launch_camera(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // if user wants to take a new photo and the camera is available
        if take_or_pick.isEnabledForSegment(at: 0) && UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        // user wants some existing photo or camera is unavailable
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // get image from dictionary
        let image = info[.editedImage] as! UIImage
        // define some new size
        let size = CGSize(width: 300, height: 300)
        // produce a new image by scaling the old image to the newly defined size
        let scaledImage = image.af_imageScaled(to: size)
        // pit picture on screen
        photo_to_post.image = scaledImage
        // dismiss?
        dismiss(animated: true, completion: nil)
    }

    // tap on white area to dismiss keyboard
    @IBAction func dismiss_keyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        // sends user back to feed view controller
        self.dismiss(animated: true, completion: nil)
    }
}
