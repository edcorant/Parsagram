//
//  Feed_View_Controller.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/1/20.
//

import UIKit
import Parse
import AlamofireImage

class Feed_View_Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feed_view: UITableView!
    
    var post_feed = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        feed_view.delegate = self
        feed_view.dataSource = self
        
        feed_view.rowHeight = view.frame.height / 2
        feed_view.estimatedRowHeight = feed_view.rowHeight
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fetch the "Posts" table from the database
        let query = PFQuery(className: "Posts")
        // set key equal to "Owner" attribute
        query.includeKey("Owner")
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
        return post_feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post_Cell") as! Post_Cell
        let post = post_feed[indexPath.row]
        
        let owner = post["Owner"] as! PFUser
        cell.post_owner.text = owner.username
        cell.post_caption.text = post["Caption"] as? String
        
        let image = post["Image"] as! PFFileObject
        let resource_url = image.url!
        
        cell.post_photo.af_setImage(withURL: URL(string: resource_url)!)
        
        return cell
    }

    @IBAction func sign_out_button(_ sender: Any) {
        PFUser.logOut()
        self.dismiss(animated: true, completion: nil)
    }
}
