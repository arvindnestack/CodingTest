//
//  PostDetailsViewController.swift
//  CodingTest
//
//  Created by Arvind Tiwari on 08/09/21.
//

import UIKit

class PostDetailsViewController: UIViewController {

    @IBOutlet weak var labelPostDetails: UILabel!
    var postData: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Post Details"
        self.showData()

    }
    
    func showData(){
        
        self.labelPostDetails.text = postData?.body
    }
    

    

}
