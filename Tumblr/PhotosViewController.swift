//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Mark Kinoshita on 2/4/18.
//  Copyright © 2018 Mark Kinoshita. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var posts: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 250
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        // Network request snippet
        fetchImages()

    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchImages()
    }
    func fetchImages() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                // TODO: Reload the table view
                self.tableView.reloadData()
                 self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            cell.cellImage.af_setImage(withURL: url!)
        }
      
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

  

}
