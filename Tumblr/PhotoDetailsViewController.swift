//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Mark Kinoshita on 2/7/18.
//  Copyright © 2018 Mark Kinoshita. All rights reserved.
//

import UIKit
import AlamofireImage
class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    var post: [String: Any]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let photos = post!["photos"] as? [[String: Any]] {
            let photo = photos[0]
            // 2.
            let originalSize = photo["original_size"] as! [String: Any]
            // 3.
            let urlString = originalSize["url"] as! String
            // 4.
            let url = URL(string: urlString)
            // photos is NOT nil, we can use it!
            // TODO: Get the photo url
            detailImageView.af_setImage(withURL: url!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   

   
 

}
