//
//  Feed_View_Controller.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/1/20.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class Feed_View_Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var feed_view: UITableView!
    
    let type_box = MessageInputBar()
    var post_feed = [PFObject]()
    var show_type_box = false
    var selected_post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        feed_view.delegate = self
        feed_view.dataSource = self
        
        feed_view.rowHeight = view.frame.height / 2
        feed_view.estimatedRowHeight = feed_view.rowHeight
        
        feed_view.keyboardDismissMode = .interactive
        
        type_box.inputTextView.placeholder = "Add a comment..."
        type_box.sendButton.title = "Post"
        type_box.delegate = self
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(hide_keyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fetch the "Posts" table from the database
        let query = PFQuery(className: "Posts")
        // set key equal to "Owner" attribute
        query.includeKeys(["Owner", "Comments", "Comments.Author"])
        // get 20 posts at a time
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.post_feed = posts!
                self.feed_view.reloadData()
            }
            
            else {
                print("Error: \(error?.localizedDescription).")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let post = post_feed[section]
        let comments = (post["Comments"] as? [PFObject]) ?? []
        
        return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return post_feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let post = post_feed[indexPath.section]
        let comments = (post["Comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post_Cell") as! Post_Cell
            
            let owner = post["Owner"] as! PFUser
            cell.post_owner.text = owner.username
            cell.post_caption.text = post["Caption"] as? String
            
            let image = post["Image"] as! PFFileObject
            let resource_url = image.url!
            
            cell.post_photo.af_setImage(withURL: URL(string: resource_url)!)
            
            return cell
        }
        
        else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Comment_Cell") as! Comment_Cell
            let comment = comments[indexPath.row - 1]
            
            cell.commentator.text = comment["Author"] as? String
            cell.comment.text = comment["Text"] as? String
            
            return cell
        }
        
        else {
            return feed_view.dequeueReusableCell(withIdentifier: "Add_Comment_Cell")!
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        // create a new comment
        let comment = PFObject(className: "Comments")
        comment["Text"] = text
        comment["Post"] = selected_post
        comment["Author"] = PFUser.current()!
        
        selected_post.add(comment, forKey: "Comments")
        
        selected_post.saveInBackground { (success, error) in
            if success {
                print ("Comment posted successfully.")
            }
            
            else {
                print("Failed to post comment.")
            }
        }
        
        feed_view.reloadData()
        
        // clear and dismiss the type bar
        hide_keyboard(nil)
        type_box.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = post_feed[indexPath.section]
        let comments = (post["Comments"] as? [PFObject]) ?? []

        if indexPath.row == comments.count + 1 {
            show_type_box = true
            becomeFirstResponder()
            type_box.inputTextView.becomeFirstResponder()
            
            selected_post = post
        }
    }

    @IBAction func sign_out_button(_ sender: Any) {
        PFUser.logOut()
        
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let login_vc = main.instantiateViewController(identifier: "Login_Screen")
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//
//        delegate.window?.rootViewController = login_vc
        
        dismiss(animated: true, completion: nil)
    }
    
    override var inputAccessoryView: UIView? {
        return type_box
    }
    
    override var canBecomeFirstResponder: Bool {
        return show_type_box
    }
    
    @objc func hide_keyboard(_ note: Notification?) {
        type_box.inputTextView.text = nil
        show_type_box = false
        becomeFirstResponder()
    }
}
