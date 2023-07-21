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
        bodyTextView.text = "What would you like to write?"
        
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
//    init?(post: Post?, coder: NSCoder) {
//        self.post = post
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    private func createPost(title: String, body: String) {
        Task {
            do {
                let apiController = APIController()
                let _ = try await apiController.createPost(title: title, body: body)
                performSegue(withIdentifier: "postUnwind", sender: self)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func editPost(post: Post) {
        Task {
            do {
                let apiController = APIController()
                let _ = try await apiController.editPost(post: post)
                performSegue(withIdentifier: "editUnwind", sender: self)
            }
            catch {
                print(error)
            }
        }
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        if let title = titleTextField.text, let body = bodyTextView.text {
            if let post = post {
                editPost(post: post)
            } else {
                createPost(title: title, body: body)
            }
        }

    }
    //Add in Posts here, Implementation to
    //Title, text, that's all we need to ADD
    
    // Sets post.title + post.body to whatever it's set to
    //user = whoever the logged in user is
    //comments = 0, likes = 0
    
    //saves Post when the "done" is tapped


}
