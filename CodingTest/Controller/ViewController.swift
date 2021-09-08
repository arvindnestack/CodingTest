//
//  ViewController.swift
//  CodingTest
//
//  Created by Arvind Tiwari on 08/09/21.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var postSearchBar: UISearchBar!
    
    var filterPostsData : [Post] = []
    var postsData : [Post] = []{
        didSet{
            self.postTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    func updateUI(){
        
        self.postTableView.keyboardDismissMode = .onDrag
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        self.postTableView.rowHeight = UITableView.automaticDimension
        self.postTableView.estimatedRowHeight = 50.0;
        self.getPosts()
    }
    
    func getPosts() {
        
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        APIManager.defaultManager.getPosts(completionHandler: { (response) in
            
            
            if let jsonData = try? JSONSerialization.data(withJSONObject:response as Any) {
                
                let decoder = JSONDecoder()
                
                self.postsData = try! decoder.decode(Array<Post>.self, from: jsonData)
                self.filterPostsData = try! decoder.decode(Array<Post>.self, from: jsonData)
                
            }
            //            print(response)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postCell = tableView.dequeueReusableCell(withIdentifier: "customPostTableViewCell", for: indexPath) as! CustomPostTableViewCell
        postCell.accessoryType = .disclosureIndicator
        postCell.configureData(postData: postsData[indexPath.row])
        
        return postCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let postDetails: PostDetailsViewController =  storyBoard.instantiateViewController(withIdentifier: "PostDetailsViewController") as! PostDetailsViewController
        
        postDetails.postData = postsData[indexPath.row]
        self.navigationController?.pushViewController(postDetails, animated: true)
        
    }
}

extension ViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchData = searchBar.text {
            if searchData.count > 2{
                self.filterPostData(searchData: searchData)
            }
            else{
                self.postsData = self.filterPostsData
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterPostData(searchData: String){
        
        self.postsData = self.postsData.filter { $0.title.lowercased() .contains(searchData.lowercased()) }
    }
}

