//
//  ListViewController.swift
//  AlamofireProject
//
//  Created by CitySpidey on 8/24/20.
//  Copyright © 2020 Shubham Bhadauria. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class ListViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    var arrOfUser = [LiveNewsModel]()
    var arrOfCurrent = [LiveNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpSearchBar()
        self.makeRequest()
        self.alterLayout()
    }
    
    func alterLayout(){
        tableView.tableHeaderView = UIView()
        tableView.estimatedSectionHeaderHeight = 50;
    }
    
    private func setUpSearchBar(){
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    
    func makeRequest(){
        SVProgressHUD.show(withStatus: "Loading...")
    
        AF.request(Constants.url).response { response in
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(UserDetail.self, from: data)
                    
                    for data in (newsResponse.articles)! as [LiveNewsModel] {
                        self.arrOfUser.append(LiveNewsModel(author: data.author!, title: data.title!, description: data.description!, url: data.url!, urlToImage: data.urlToImage!, publishedAt: data.publishedAt!))
                    }
                    
                    if self.arrOfUser.count > 0 {
                        self.arrOfCurrent = self.arrOfUser
                        
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
                SVProgressHUD.dismiss()
            }
            else {
                SVProgressHUD.dismiss()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrOfCurrent.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as! NewsViewCell
        cell.users = arrOfCurrent[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            arrOfCurrent = arrOfUser
            tableView.reloadData()
            return
        }
        
        arrOfCurrent = arrOfUser.filter({author -> Bool in
            print("\(author.author!)")
            guard let text = searchBar.text else { return false }
            return (author.author?.lowercased().contains(text.lowercased()))!
        })
        print(arrOfCurrent)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrOfCurrent = arrOfUser
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

}

