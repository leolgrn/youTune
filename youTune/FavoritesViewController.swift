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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func loadFavorites() {
        
        print("start func")
        let basePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("favorites.json")
        
        // print(filePath)
        print("file path create")
        guard let data = try? Data(contentsOf: filePath),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let arr = json as? [[String:Any]]
            else {
                print("guard failed")
                self.noFavLabel.isHidden = false
                return
        }
        
        print("Before arr printed")
        print(arr)
        print("arr printed")
        var videos: [String]
        
        
    }
    

}
/*
extension FavoritesViewController: UITableViewDataSource{
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

extension FavoritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoId = self.request.id[indexPath.row]
        let descriptionVideo = self.request.descriptions[indexPath.row]
        let videoViewController = VideoViewController()
        videoViewController.videoId = videoId
        videoViewController.descriptionVideo = descriptionVideo
        self.navigationController?.pushViewController(videoViewController, animated: true)
    }
}*/
