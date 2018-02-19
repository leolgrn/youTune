//
//  FavoritesViewController.swift
//  youTune
//
//  Created by pierre piron on 19/02/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavLabel: UILabel!
    var videos: [[String:Any]] = []
    var favorites = Favorites()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favs ❤️"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.videos = self.favorites.loadFavorites()
        self.tableView.reloadData()
    }

}

extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        if let listCell = cell as? ListTableViewCell {
            listCell.titleList.text = self.videos[indexPath.row]["title"] as? String
            listCell.channelTitleList.text = self.videos[indexPath.row]["channel"] as? String
            listCell.imageList.image = self.favorites.loadImage(idVideo: (self.videos[indexPath.row]["id"] as? String)!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension FavoritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoId = self.videos[indexPath.row]["id"]! as? String
        let descriptionVideo = self.videos[indexPath.row]["description"]! as? String
        //let videoImageURL = self.ima
        let videoName = self.videos[indexPath.row]["title"]! as? String
        let videoChannel = self.videos[indexPath.row]["channel"]! as? String
        let videoViewController = VideoViewController()
        videoViewController.videoId = videoId!
        videoViewController.descriptionVideo = descriptionVideo!
        //videoViewController.videoImageURL = videoImageURL!
        videoViewController.videoName = videoName!
        videoViewController.videoChannel = videoChannel!
        self.navigationController?.pushViewController(videoViewController, animated: true)
    }
}
