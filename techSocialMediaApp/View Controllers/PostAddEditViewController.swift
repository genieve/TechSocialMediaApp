//
//  PostAddEditViewController.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/7/23.
//

import UIKit

class PostAddEditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var post: Post?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = "Testing"
        bodyTextView.text = "PLEASE SHOW UP SDKFLJDSF"
        
        if let post = post {
            titleTextField.text = post.title
            bodyTextView.text = post.body
            title = "Edit Post"
        } else {
            title = "New Post"
        }
        
        //check how this was tapped, via Cell or via + button
        
        //If it was cell, populate the areas with current text
        //if not, have them empty and we can fill it
        
        //either way, save it when it's done.
        
        //If it's not new, don't save a NEW one, just UPDATE the old one

        // Do any additional setup after loading the view.
        // If it was tapped to edit, then pre-load it with the current post
    }
    init?(post: Post?, coder: NSCoder) {
        self.post = post
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func saveButtonHit(_ sender: Any) {
        if let title = titleTextField.text, let body = bodyTextView.text {
//            var createBody = CreatePostBody(userSecret: User.current!.secret.uuidString, post: [title: body])
//              That ^^^ is already called in the APIController
            Task {
                do {
                    let apiController = APIController()
                    let post = try await apiController.createPost(title: title, body: body)
                }
                catch {
                    print(error)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //Add in Posts here, Implementation to
    //Title, text, that's all we need to ADD
    
    // Sets post.title + post.body to whatever it's set to
    //user = whoever the logged in user is
    //comments = 0, likes = 0
    
    //saves Post when the "done" is tapped


}
