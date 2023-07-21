//
//  PostDetailViewController.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/7/23.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var post: Post?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var numberLikesLabel: UILabel!
    
    init?(coder: NSCoder, post: Post?) {
        self.post = post
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            usernameLabel.text = post.authorUserName   
            bodyLabel.text = post.body
            numberLikesLabel.text = "\(post.likes)"
            title = "\(post.title)"
        } else {
            title = "Error: Not initializing post in postDetailViewController"
        }
        // Do any additional setup after loading the view.
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
