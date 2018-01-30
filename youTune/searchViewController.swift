//
//  searchViewController.swift
//  youTune
//
//  Created by Léo LEGRON on 25/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

class searchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var request = ListInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        self.textField.delegate = self
        self.textField.placeholder = "Search for an artist, a song, an album..."
        
        self.title = "Search"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchButton() {
        request = ListInfo();
        self.request.getInformation(keyword: self.textField.text!)
        while self.request.arraysAreFull == false {}
        self.tableView.reloadData()
    }
    
}

extension searchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.request.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        if let listCell = cell as? ListTableViewCell {
            listCell.titleList.text = self.request.titles[indexPath.row]
            listCell.descriptionList.text = self.request.descriptions[indexPath.row]
            listCell.imageList.image = self.request.imageList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension searchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoId = self.request.id[indexPath.row]
        let videoViewController = VideoViewController()
        videoViewController.videoId = videoId
        self.navigationController?.pushViewController(videoViewController, animated: true)
    }
}

extension searchViewController: UITextFieldDelegate{
    
}