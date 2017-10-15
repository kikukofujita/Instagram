//
//  CommentViewController.swift
//  Instagram
//
//  Created by 藤田貴久子 on 2017/10/11.
//  Copyright © 2017年 kiki.fuji. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {
    let user = Auth.auth().currentUser
    var postData: PostData!

    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var beforeComment: UILabel!
    
    @IBAction func commenButton(_ sender: Any) {
        print("DBUG_PRINT: commentButtonが押されました。")
        if let user = user {
            let commentName = user.displayName
            
        // Firebaseに保存するデータの準備
                if (Auth.auth().currentUser?.uid) != nil {
                    if commentText.text != nil {
                        print("追加前のcommentは、\(postData.comment)")
               //     postData.comment.append(commentText.text)
                        postData.comment.append("\(commentName!) : \(commentText.text!)")
                        print("投稿したcommentは、\(postData.comment)")

            // 増えたcommentをFirebaseに保存する
                        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
                        let comment = ["comment": postData.comment]
                        postRef.updateChildValues(comment)
                        print("Firebaseに保存したcomment : \(comment)")
                        
                        
                        // HUDで投稿完了を表示する
                        SVProgressHUD.showSuccess(withStatus: "投稿しました")
                        
                        // 全てのモーダルを閉じる
                        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            } 
        }

    @IBAction func commentCancel(_ sender: Any) {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        
        homeViewController.postData = postData
        present(homeViewController, animated: true, completion: nil)
    }
    
    
    
    var postArray: [PostData] = []

/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "commentSegue" {
            
            let homeViewController:HomeViewController = segue.destination as! HomeViewController
        // 遷移先のHomeViewControllerで宣言しているx, yに値を代入して渡す
            homeViewController.image = postData.image
            homeViewController.imageString = postData.imageString
            homeViewController.name = postData.name
            homeViewController.caption = postData.caption
            homeViewController.date = postData.date
            homeViewController.comment = commentText.text
        }
    }  */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentImage.image = postData.image
        print("postData.image を設定しました。")
        
        if postData.comment != [] {
            let str = postData.comment.joined(separator: "\n")
            self.beforeComment.text = str
            
            print("以前のstrの値は、\(str)")
            print("以前のcommentは、\(postData.comment)")
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*    func setPostData(postData: PostData) {
        self.commentImage.image = postData.image
        
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
