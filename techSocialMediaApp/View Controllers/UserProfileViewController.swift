//
//  UserProfileViewController.swift
//  techSocialMediaApp
//
//  Created by Alexis Wright on 7/19/23.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var techInterestsLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let network = APIController()
    
    
    
    var posts = [Post(postid: 34, title: "TESTING AHHHH", body: "please please work", authorUserName: "alexis", authorUserId: UUID(), likes: 43, userLiked: true, numComments: 393, createdDate: "Today")]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Posts")
        view.addSubview(tableView)
                
        Task {
            do {
                let apiController = APIController()
                let userProfile = try await apiController.getUserProfile()
                updateUI(with: userProfile)
                
                let fetchedPosts = try await apiController.getAllPosts()
                //                posts = fetchedPosts
                
                posts = fetchedPosts.filter({ post in
                    // code to filter out the user's posts vs all posts
                    post.authorUserId == User.current?.userUUID
                    //                    true
                })
                
                tableView.reloadData()
                
            } catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostTableViewCell
        
        if posts.isEmpty {
            return cell
        } else {
            configure(cell: cell, forItemAt: indexPath)
        }
        return cell

    }
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
    
    func updateUI(with userProfile: UserProfile) {
        nameLabel.text = "\(userProfile.firstName) \(userProfile.lastName)"
        usernameLabel.text = "\(userProfile.userName)"
        bioLabel.text = "A student at MTECH studying Swift"
        techInterestsLabel.text = "SwiftUI, AI"
    }
    
    @IBSegueAction func showAddEdit(_ coder: NSCoder, sender: Any?) -> PostAddEditViewController? {
        guard let cell = sender as? PostTableViewCell, let indexPath = tableView.indexPath(for: cell) else { return PostAddEditViewController(post: nil, coder: coder) }
        let postToEdit = posts[indexPath.row]
        return PostAddEditViewController(post: postToEdit, coder: coder)
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
