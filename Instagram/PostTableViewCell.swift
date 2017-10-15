//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 藤田貴久子 on 2017/10/08.
//  Copyright © 2017年 kiki.fuji. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!

    let str:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        print("postData.caption = \(String(describing: postData.caption))")
        print("表示するcommentは、\(postData.comment)")
        
        if postData.comment != [] {
            let str = postData.comment.joined(separator: "\n")
            self.commentLabel.text = str
            
            print("strの値は、\(str)")
            print("commentは、\(postData.comment)")
        }
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for:UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
    }
}
