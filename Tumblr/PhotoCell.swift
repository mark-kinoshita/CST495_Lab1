//
//  PhotoCell.swift
//  Tumblr
//
//  Created by Mark Kinoshita on 2/4/18.
//  Copyright © 2018 Mark Kinoshita. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }

}
