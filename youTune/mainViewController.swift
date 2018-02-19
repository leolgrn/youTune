//
//  mainViewController.swift
//  youTune
//
//  Created by Léo LEGRON on 12/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit


//class main

class mainViewController: UIViewController{
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let request = ListInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        // Navigation Bar
        
        self.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchController))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(favoritesController))
        
        // Call + reloadData of tableView
        self.request.getInformation(keyword: "")
        while self.request.arraysAreFull == false {}
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchController() {
        self.navigationController?.pushViewController(searchViewController(), animated: true)
    }
    
    @IBAction func favoritesController() {
        self.navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
}

//extensions

extension mainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.request.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        if let listCell = cell as? ListTableViewCell {
            listCell.titleList.text = self.request.titles[indexPath.row]
            listCell.channelTitleList.text = self.request.channelTitles[indexPath.row]
            listCell.imageList.image = self.request.imageList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension mainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoId = self.request.id[indexPath.row]
        let descriptionVideo = self.request.descriptions[indexPath.row]
        let videoImage = self.request.imageList[indexPath.row]
        let videoName = self.request.titles[indexPath.row]
        let videoChannel = self.request.channelTitles[indexPath.row]
        let videoViewController = VideoViewController()
        videoViewController.videoId = videoId
        videoViewController.descriptionVideo = descriptionVideo
        videoViewController.videoImage = videoImage
        videoViewController.videoName = videoName
                videoViewController.videoChannel = videoChannel
        self.navigationController?.pushViewController(videoViewController, animated: true)
    }
}


