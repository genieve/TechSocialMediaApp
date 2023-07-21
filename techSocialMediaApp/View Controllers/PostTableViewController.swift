//
//  PostTableViewController.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/7/23.
//

import UIKit

class PostTableViewController: UITableViewController {

    
    
    var posts: [Post] = []
    var postController = PostController()

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            do {
                let apiController = APIController()
                
                let fetchedPosts = try await apiController.getAllPosts()
                
                posts = fetchedPosts
                
                tableView.reloadData()
                
            } catch {
                print(error)
            }
        }
        tableView.separatorStyle = .none
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PostTableViewCell {
        //Dequeue Cell and make sure [posts] isn't empty
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostTableViewCell
        
        if posts.isEmpty {
            return cell
        } else {
            configure(cell: cell, forItemAt: indexPath)
        }
        return cell
    }
    
//      MARK --
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // One of these - This is where we check to see if the post is already in the array of posts or not - if the post.id and the user are the same, then we EDIT the current post, otherwise we .append to the posts array
    func didCreatePost(_ post: Post) {
        tableView.reloadData()
    }
     
    @IBSegueAction func showDetailView(_ coder: NSCoder, sender: Any?) -> PostDetailViewController? {
        if let cell = sender as? PostTableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let postToShow = posts[indexPath.row]
            
            return PostDetailViewController(coder: coder, post: postToShow)
        } else {
            return PostDetailViewController(coder: coder, post: nil)
        }
    }

    @IBAction func addPost(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let saveButtonHitVC = storyboard.instantiateViewController(withIdentifier: "PostAddEditViewController") as? PostAddEditViewController {
                    saveButtonHitVC.post = nil
                    navigationController?.pushViewController(saveButtonHitVC, animated: true)
                }

    }
//    @IBSegueAction func addPost(_ coder: NSCoder, sender: Any?) -> PostAddEditViewController? {
//        let saveButtonHitVC = PostAddEditViewController(post: nil, coder: coder)
//        saveButtonHitVC?.delegate = self // Set the delegate to receive the created post
//        navigationController?.pushViewController(saveButtonHitVC ?? PostAddEditViewController(post: nil, coder: coder)!, animated: true)
//
//        return saveButtonHitVC
//    }
//
    
    // MARK: FORMAT AND API FETCH FUNCTIONS
    
    //Call pullPosts, display the posts that you call
    
    func configure(cell: PostTableViewCell, forItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        
        cell.bodyLabel.text = post.body
        cell.titleLabel.text = post.title
        cell.userameLabel.text = post.authorUserName
//        cell.dateLabel.text = post.createdDate.formatted(date: .abbreviated, time: .shortened)
        cell.numLikesLabel.text = "\(post.likes)"
        cell.numCommentsLabel.text = post.numComments == 1 ? "1 comment" : "\(post.numComments) comments"
        //assign the cell text to the current post
    }
    
}